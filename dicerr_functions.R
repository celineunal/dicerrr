library(imager)
library(dplyr)

GetMeasurements <- function(bin_count_w, mat) {
  bin_size<- floor(nrow(mat)/bin_count_w)
  bin_count_h <- floor(ncol(mat)/bin_size)
  return(list(bin_count_w=bin_count_w, bin_count_h=bin_count_h, bin_count=bin_count_w*bin_count_h, bin_size=bin_size))
}

BuildIndex <- function(img_measurements) {
  index_w <- seq(0, img_measurements$bin_count_w * img_measurements$bin_size - 1, img_measurements$bin_size)
  index_h <- seq(0, img_measurements$bin_count_h * img_measurements$bin_size - 1, img_measurements$bin_size)
  return(list(index_w = index_w, index_h = index_h))
}

SubsetMatrix <- function(matrix, index_row_start, index_row_end, index_col_start, index_col_end) {
  return(matrix[index_row_start:index_row_end, index_col_start, index_col_end])
}

Dicerr <- function(width_in_dice = 50, img_path) {
  img <- load.image(img_path) %>%
    grayscale() #imager package (pipe from dplyr package)
  
  measurements <- GetMeasurements(width_in_dice, as.matrix(img))
  indices <- BuildIndex(measurements)
  
  img_normalized <- (1 - as.matrix(img)) * 6
  
  dice_matrix <- matrix(nrow = measurements$bin_count_w, ncol=measurements$bin_count_h)
  
  m.w = 0
  m.h = 0
  
  for(i in indices$index_w){
    m.h <- 0
    m.w <- m.w + 1
    
    for (j in indices$index_h){
      m.h <- m.h + 1
      die <- img_normalized[i:(i+measurements$bin_size-1), j:(j+measurements$bin_size-1)]
      dice_matrix[m.w,m.h] <- ceiling(mean(die))
    }
  }
  return(t(dice_matrix))
}