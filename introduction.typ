#import "@preview/cetz:0.2.2"

#let introduction = [
= Introduction
Consider the challenge of capturing perfectly rectangular objects, such as a book page, when photographed from an angle or non-standard perspective. The resulting image often needs to be cropped and distorted to restore its conventional rectangular appearance. Image editing software addresses this issue by allowing users to select four points that define a quadrilateral, which can then be transformed into a rectangle with the correct dimensions.
#figure(
  grid(
      columns: 2,
      gutter: 0.2mm,
      image(
        "uncroppedintro.jpg",
        width: 120pt, height: 200pt
      ),
      image(
        "croppedintro.jpg",
        width: 120pt, height: 200pt
      )
  ),
  caption: "Example of transformation of image in software."
)<origalg>

The aim of this investigation is to explore the mathematics behind this transformation, and hence answer the question \
#align(center)[
  #figure(
    box(inset: 2pt, outset: 2pt, radius: 1pt, stroke: 1pt)[
      *What is the transformation between an arbitary convex quadrilateral and an arbitrary rectangle?*
    ]
  )<researchquestion>
]

= Formulating the Problem
#columns(1, gutter: 40pt)[
== Given Information
#underline[Initial Quadrilateral]:

$A B C D$ with vertices at $A(x_A, y_A)$, $B(x_B, y_B)$, $C(x_C, y_C)$, $D(x_D, y_D)$

#underline[Final Quadrilateral]

$A'B'C'D'$ with vertices at $A'(x_A', y_A')$, $B'(x_B', y_B')$, $C'(x_C', y_C')$, $D'(x_D', y_D')$

#figure(
grid(
  columns: (1fr, 1fr),
  gutter: 3pt,
  cetz.canvas(length: 1.5cm, {
  import cetz.draw: *

  set-style(
    mark: (fill: black, scale: 2),
    stroke: (thickness: 0.4pt, cap: "round"),
    angle: (
      radius: 0.3,
      label-radius: .22,
      fill: green.lighten(80%),
      stroke: (paint: green.darken(50%))
    ),
    content: (padding: 1pt)
  )
  line((-1, 1), (0.3, 1))
  content((-1.1,1), $ A $, anchor: "east")
  content((0.4,1), $ B $, anchor: "west")
  line((0.3, 1), (0.9, -0.3))
  content((0.9,-0.4), $ C $, anchor: "north")
  line((0.9, -0.3), (-1.5, 0.1))
  content((-1.5, 0), $ D $, anchor: "north")
  line((-1,1), (-1.5, 0.08))
}),
  cetz.canvas(length: 1.5cm, {
  import cetz.draw: *
  set-style(
    stroke: (thickness: 0.7pt, cap: "round"),
  )
  line((-2.2,0.5), (-1.3,0.5), mark: (end: "stealth"))
  set-style(
    mark: (fill: black, scale: 2),
    stroke: (thickness: 0.4pt, cap: "round"),
    angle: (
      radius: 0.3,
      label-radius: .22,
      fill: green.lighten(80%),
      stroke: (paint: green.darken(50%))
    ),
    content: (padding: 1pt)
  )
  rect((-1,1), (0.2,-0.3))
  content((-1,1), "A'", anchor: "east")
  content((0.2,1), "B'", anchor: "west")
  content((-1,-0.3), "D'", anchor: "east")
  content((0.2,-0.3), "C'", anchor: "west")
  content((-1.75,0.6), $T$, anchor: "south")
}),
),
caption: "Transformation of " + $A B C D$ + " to " + $A'B'C'D'$
)<desired_output>
]
== Desired Result
#v(12pt)
#align(center)[
  #box(stroke: 1pt, inset: 2pt, outset: 2pt)[
    *Find a transformation $T$ such that $T(A B C D) = A'B'C'D'$*
  ]
]
]