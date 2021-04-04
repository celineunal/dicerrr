source("dicerr_functions.R")
source("draw_functions.R")

# Usage example for one image -------

img_path = "example-files/cat-original.jpg" #replaxce w/ image path

dice_matrix <- Dicerr(200, img_path)

bmp("example-files/cat-diced.bmp", width = 2000, height = 1420)
Draw(dice_matrix, 10)
dev.off()

# Example w/ multiple video frames. Frames were extracted from video with ffmpeg.
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

