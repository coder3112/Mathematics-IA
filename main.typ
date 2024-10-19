#import "template.typ": *

#import "introduction.typ": *
#import "matrices.typ": *
#import "split_cases.typ": *

#show: template.with(
  title: "Transformation of Quadrilaterals into Rectangles",
  subtitle: v(0pt),
  font-face: "New Computer Modern",

  colour_fg: rgb(0,0,0),
  colour_bg: rgb(250,250,255),
  colour_accent: rgb(0,0,0),

  header_title:[
    Mathematics Analysis and Approaches Higher Level $divides$ Internal Assessment
  ],
  paper_size: "a4",
  heading_numbering: "1.1.1.i",
)

#introduction
#pagebreak(weak: true)
#matrices
#split_cases