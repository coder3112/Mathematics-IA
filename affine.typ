#import "@preview/cetz:0.3.0"

#let affine = [
  = Affine Transformations
  == Rotation
  A rotation matrix $R$ is represented by:
  $
  R = mat(
    cos theta, -sin theta;
    sin theta, cos theta
  )
  $

  Of course, we can note here that finding the rotation matrix for a single edge should be enough: all edges must have been rotated by the same angle, and therefore, the same matrix will apply to all of them. This is also the primary benefit of matrices as tools to find transformations: they can be applied on the plane uniformly.
  
  #figure(
  grid(
    columns: (1fr, 1fr),
    gutter: -163pt,
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
    line((-3,0.5), (-2,0.5), mark: (end: "stealth"))
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
    rotate(z: 45deg)
    line((-1, 1.2), (0.3, 1.2))
    content((-1.1,1.2), $ A' $, anchor: "east")
    content((0.4,1.2), $ B' $, anchor: "west")
    line((0.3, 1.2), (0.9, -0.1))
    content((0.9,-0.2), $ C' $, anchor: "north")
    line((0.9, -0.1), (-1.5, 0.3))
    content((-1.5, 0.2), $ D' $, anchor: "north")
    line((-1,1.2), (-1.5, 0.28))
  }),
  ),
  caption: "Rotation of" + $A B C D$ + " to " + "A'B'C'D'"
  )<rotated_output>

  
  // However, computing trigonometric functions would be incredibly hard. Instead, we will use the dot and cross products, since they incorporate that into nicer vector/matrix algebra.

  
  
  // *PLEASE NOTE THAT THE REST OF THE MATH WAS SHOWN IN THE PREVIOUSLY SUBMITTED DRAFT, AND WE DISCUSSED IT IN OUR MEETING. I AM WRITING THE DRAFT IN A NEW DOCUMENT NOW TO INCORPORATE OUR DISCUSSION, WHICH IS WHY THIS DOCUMENT DOES NOT CONTAIN THAT (YET)*
]