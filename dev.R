# Dicerrr

library(imager)
library(dplyr)

img <- load.image("bakunin.jpg") %>%
  grayscale() %>%
  imsub(x<=1050)

get_measurements <- function(w, mat){
  dice_size_w <- floor(nrow(mat)/w)
  dice_count_h <- floor(ncol(mat)/dice_size_w)
  return(list(dice_count_w=w, dice_count_h=dice_count_h, dice_count=w*dice_count_h, dice_size=dice_size_w))
}

indexBuilder <- function(img_measurements){
  index_w <- seq(1, img_measurements$dice_count_w * img_measurements$dice_size, img_measurements$dice_size)
  index_w <- index_w[-length(index_w)]
  index_h <- seq(1, img_measurements$dice_count_h * img_measurements$dice_size, img_measurements$dice_size)
  index_h <- index_h[-length(index_h)]
  return(list(index_w = index_w, index_h = index_h))
}

normalize_mat <- function(mat, lower, upper){
  mat.n <- lower + ((mat - min(mat)) * (upper - lower)) / (max(mat) - min(mat))
  return(mat.n)
}

dicerr <- function(w, img){
  m <- get_measurements(w, img)
  indices <- indexBuilder(m)
  
  img.n <- normalize_mat(as.matrix(img), 1, 6)
  img.n <- img.n - mean(img.n) + 3
  
  dice.mat <- matrix(nrow = m$dice_count_w, ncol=m$dice_count_h)
  
  m.w = 1
  m.h = 1
  
  for(i in indices$index_w){
    for (j in indices$index_h){
      die <- img.n[i:(i+m$dice_size), j:(j+m$dice_size)]
      dice.mat[m.w,m.h] <- round(mean(die))
      print(paste0("j: ", j))
      m.h <- m.h + 1
    }
    print(i)
    m.w <- m.w + 1
  }
}

mat.to.image <- function(mat){
  
}