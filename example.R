source("dicerr_functions.R")
source("draw_functions.R")

##############################
# Example for a single image #
##############################

img_path = "example-files/person_leaning_original.jpg" #replace w/ image path

# This example image is already grayscale, but the next step is needed
# for color images:
img <- load.image(img_path) %>%
  grayscale() #imager package (pipe from dplyr package)

# 250 dice across, maintains original aspect ratio:
dice_matrix <- Dicerr(250, img_path)

# Width of a single die face image in pixels
dice_width <- 20

# Note that the matrix representation of an image in the imager package
# is transposed, i.e. width = ncol
png("example-files/person_leaning_diced.png", width = ncol(dice_matrix)*dice_width, height = nrow(dice_matrix)*dice_width)
Draw(dice_matrix, dice_width)
dev.off()

####################################
# Example w/ multiple video frames #
# Frames were extracted from video #
# with ffmpeg.                     #
# See https://www.ffmpeg.org/.     #
####################################

fs <- list.files("example-files/seagulls-frames/original")
fs <- paste0("example-files/seagulls-frames/original/", fs)

for (i in fs) {
  
  dice_matrix <- Dicerr(60, i)

  bmp(paste0(gsub("original", "diced", tools::file_path_sans_ext(i)), ".bmp"),
      width = 600,
      height = 340)
  Draw(dice_matrix, 10)
  dev.off()
}

# The diced frames can now be assembled back with ffmpeg
