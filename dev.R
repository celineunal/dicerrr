# Dicerrr

library(imager)
library(dplyr)

img <- load.image("bakunin.jpg") %>%
  grayscale() %>%
  imsub(x<=1050)

get_measurements <- function(w, mat){
  dice_size_w <- floor(nrow(mat)/w)
  dice_count_h <- floor(ncol(mat)/dice_size_w)
  return(list(dice_count_w=w, dice_count_h=dice_count_h, dice_count=w*dice_count_h, dice_size=dice_size))
}

indexBuilder <- function(img_measurements){
  index_w <- seq(1, img_measurements$dice_count_w, img_measurements$dice_size)
  index_h <- seq(1, img_measurements$dice_count_h, img_measurements$dice_size)
}

dicerr <- function(img){
  m <- get_measurements(100, image)
  indices<= indexBuilder(m)
  index_w <- indices$index_w
  index_h <- indices$index_h
  
  mat <- matrix(nrow = m$dice_count_w, ncol=m$dice_count_h)
  
  
}