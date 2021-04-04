library(gtable)
library(rsvg)
library(png)
library(gridExtra)
library(grid)

dice_imgs <- c("one.svg", "two.svg", "three.svg", "four.svg", "five.svg", "six.svg")

SvgToPng <- function(svg, width){
  png <- rsvg_png(svg = svg, width=width) # rsvg package
  png <- readPNG(png) # png package
  return(png)
}

ReadDice <- function(dice_width){
  dice_png <- lapply(paste0("die-faces/", dice_imgs), SvgToPng, width = dice_width)
  dice_grob <- lapply(dice_png, grid::rasterGrob)
  return(dice_grob)
}

ListReplacer <- function(i, list){
  i <- list[[i]]
  return(i)
}

Draw <- function(matrix, dice_width){
  dice <- ReadDice(dice_width)
  grob_matrix <- apply(matrix, c(1,2), ListReplacer, list=dice)
  gt <- gtable_matrix(name="diced", 
                      grobs = grob_matrix,
                      widths = unit(rep("1", ncol(grob_matrix)), "null"),
                      heights = unit(rep("1", nrow(grob_matrix)), "null"),
                      z = matrix,
                      respect=TRUE) #grid package
  
  grid.arrange(gt) #gridExtra package
}