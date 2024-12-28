#import "template.typ": *

#import "introduction.typ": *
#import "matrices.typ": *
#import "split_cases.typ": *
#import "affine.typ": *
#import "non_affine.typ": *
#import "appendix.typ": *
#import "appendixb.typ": *

#show: template.with(
  title: "Transformation of Quadrilaterals into Rectangles",
  subtitle: v(0pt),
  font-face: "New Computer Modern",

  colour_fg: rgb(0,0,0),
  colour_bg: rgb(255,255,255),
  colour_accent: rgb(0,0,0),

  header_title:[
    Mathematics Analysis and Approaches Higher Level $divides$ Internal Assessment
  ],
  paper_size: "a4",
  heading_numbering: "1.1.1.i",
)

#introduction
#matrices
#split_cases
#affine
#non_affine
#pagebreak(weak: true)
#bibliography("main.bib")
#pagebreak(weak: true)
#appendix_code
// #pagebreak(weak: true)
// #appendix_b

// https://web.archive.org/web/20100801071311/http://alumni.media.mit.edu/%7Ecwren/interpolator/