# Dicerr

A small R program that can:

1.  Take in an image and output a matrix that describes how to recrate the image with dice.

2.  Recreate the image with a collection of die face images.

## Examples

<p align="center">

<img src="example-files/person_leaning_original.jpg" title="Stock photo of a person." alt="Shows a person standing up, slightly leaning back." height="400"/> <img src="example-files/person_leaning_diced.png" title="Diced image of the person." alt="The same photo recreated with images of die faces." height="400"/>

</p>

Here is a video (Used ffmpeg to extract original frames, then combine diced frames):

<p align="center">

<img src="example-files/seagulls-original.gif" title="Seagulls stock footage" alt="Stock footage of a flock of seagulls flying above." width="250"/> <img src="example-files/seagulls-diced.gif" title="Seagulls diced footage." alt="The seagulls video recreated with images of die faces." width="250"/>

</p>

## Getting Started

### Dependencies

Following R packages were used:

-   imager
-   dplyr
-   gtable
-   rsvg
-   png
-   grid
-   gridExtra

### Executing program

There is no UI or executable as of now. You can run the code in an R IDE/compiler.

## Author

Celine Unal [me\@celineunal.com](mailto:me@celineunal.com){.email}

## Version History

0.1 Initial release

## License

This project is licensed under the MIT License - see the LICENSE.txt file for details
