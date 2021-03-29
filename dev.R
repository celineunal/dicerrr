# Dicerrr

library(imager)
library(dplyr)
library(gtable)
library(rsvg)
library(png)
library(lattice)
library(gridExtra)
library(grid)
library(ggplot2)
library(BBmisc)

dice.imgs <- c("one.svg", "two.svg", "three.svg", "four.svg", "five.svg", "six.svg")

img <- load.image("us.jpg") %>%
  grayscale()

get.measurements <- function(w, mat){
  dice_size_w <- floor(nrow(mat)/w)
  dice_count_h <- floor(ncol(mat)/dice_size_w)
  return(list(dice_count_w=w, dice_count_h=dice_count_h, dice_count=w*dice_count_h, dice_size=dice_size_w))
}

indexBuilder <- function(img_measurements){
  index_w <- seq(0, img_measurements$dice_count_w * img_measurements$dice_size - 1, img_measurements$dice_size)+1
  index_h <- seq(0, img_measurements$dice_count_h * img_measurements$dice_size - 1, img_measurements$dice_size) + 1
  return(list(index_w = index_w, index_h = index_h))
}

dicerr <- function(w, img){
  m <- get.measurements(w, as.matrix(img))
  indices <- indexBuilder(m)

  img.n <- normalize(as.matrix(img), method = "range", range = c(6,1))
  
  dice.mat <- matrix(nrow = m$dice_count_w, ncol=m$dice_count_h)
  
  m.w = 0
  m.h = 0
  
  for(i in indices$index_w){
    m.h <- 0
    m.w <- m.w + 1

    for (j in indices$index_h){
      m.h <- m.h + 1
      die <- img.n[i:(i+m$dice_size-1), j:(j+m$dice_size-1)]
      dice.mat[m.w,m.h] <- round(mean(die))
    }
  }
  dice.mat <- dice.mat
  return(t(dice.mat))
}

svg.to.png <- function(svg, width){
  png <- rsvg_png(svg = svg, width=width)
  png <- png::readPNG(png)
  return(png)
}

read.dice <- function(diceWidth){
  dicePng <- lapply(paste0("die-faces/", dice.imgs), svg.to.png, width = diceWidth)
  diceGrob <- lapply(dicePng, rasterGrob)
  return(diceGrob)
}

replacer <- function(i, list){
  i <- list[[i]]
  return(i)
}

draw <- function(matrix, diceWidth){
  dice <- read.dice(diceWidth)
  grobMatrix <- apply(matrix, c(1,2), replacer, list=dice)
  gt <- gtable_matrix(name="diced", 
                      grobs = grobMatrix, 
                      widths = unit(rep("1", ncol(grobMatrix)), "null"),
                      heights = unit(rep("1", nrow(grobMatrix)), "null"),
                      z = matrix, 
                      respect=TRUE)
  
  grid.arrange(gt)
}