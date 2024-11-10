#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge

#import "template.typ": *

#let split_cases = [
= Affine and Non-Affine Transformations
On the whole, our transformations can be categorised into two (disjoint) sets based on the behaviour of parallel lines which undergo the transformation.
- *Affine transformations* preserve parallelism. Lines which were parallel before the transformation stay parallel
- *Non-Affine transformations* can change the angle between parallel lines. Lines which were parallel before the transformation do not stay parallel.

Based on this, we can classify our #link(<researchquestion>)[research question] into the following (sub-) categories:

#align(center)[
  #figure(diagram(
    cell-size: 15mm,
    node-defocus: 0,
    spacing: (1cm, 2cm),
    node-stroke: 1pt,
    edge-stroke: 1pt,
    crossing-thickness: 5,
    mark-scale: 70%,
    node-outset: 3pt,
  
    node((0,0), "Transformations"),
    node((-1,0.3), "Affine"),
    node((1,0.3), "Non-Affine"),
    node((-0.858,0.5), "Rotation", inset: 2pt, stroke: 0pt),
    node((-0.83,0.65), "Squeezing", inset: 2pt, stroke: 0pt),
    node((-0.89,0.8), "Scaling", inset: 2pt, stroke: 0pt),
    node((0.95,0.5), "Warping", inset: 2pt, stroke: 0pt),
    {
  		let arrow(a, b, label, paint, ..args) = {
        paint = paint.darken(25%)
        edge(a, b, "->", stroke: paint, label-side: center, ..args)
  		}
    let arrow2(a, b, label, paint, ..args) = {
        paint = paint.darken(25%)
        edge(a, b, "-", stroke: paint, label-side: center, ..args)
  		}

      arrow((0,0), (-1, 0.3), "" , black)
      arrow((0,0), (1, 0.3), "" , black)
      // Left hand side
      arrow2((-1.2999,0.41), (-1.299, 0.8), "" , black,)
      arrow((-1.3,0.5), (-1.15, 0.5), "" , black)
      arrow((-1.3,0.65), (-1.15, 0.65), "" , black)
      arrow((-1.3,0.5), (-1.15, 0.5), "" , black)
      arrow((-1.3,0.8), (-1.15, 0.8), "" , black)
      // Right hand side
      arrow2((1.41,0.41), (1.41, 0.5), "" , black)
      arrow((1.41,0.5), (1.25, 0.5), "" , black)
    },
  ))<categorisation>
]

]