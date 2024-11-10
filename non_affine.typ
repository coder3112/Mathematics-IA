#import "@preview/cetz:0.3.0"

#import "template.typ": example

#let non_affine = [
  = Non Affine Transformations
  We have seen above that affine transformations can help with rotation, scaling etc. but is not helpful in actually converting "shapes". This means, that a trapezium cannot be converted into a rectangle and so on. This is because these shapes have a different set of lines which are parallel $dash$ their axes must be transformed/warped. 

  For this, a projective transform is necessary. However, before that can be described, one must discuss homogeneous coordinate systems.

  == Homogeneous Coordinates
  Homogeneous or Projective Coordinates are coordinates that:
  + If they are multiplied by a (non-zero) _scalar_, then the resulting coordinates represent the same point.
  + They allow translation to be represented with matrices the same way scaling and rotation is.
  
  #figure(
    //http://www.songho.ca/math/homogeneous/homogeneous.html
    caption: [Each of the points on the orange line are equivalent in homogeneous coordinates. Source: songho],
    image("homogeneous_coordinates_example.png", width: 40%),
  )
  
  Imagine projecting a 2D image onto a screen. Then, there are obviously X and Y dimensions of the image. However, there is also a coordinate W, i.e. the distance of the projector from the screen. If it increases, the image gets bigger, and if it decreases, the image gets smaller. 
  
  The (X, Y) coordinates are Cartesian, and adding W into the mix allows us to discuss projective geometry. Hence, in this case we would have (X, Y, W) and these are the homogeneous coordinates. This will help us solve the problem of uniformly representing a transformation. 
  
  This is better than 3D coordinates for the following causes:
  + Two different planes always intersect at a point
  + A line and a plane (almost) always intersect at a point
  + We can represent cases at "infinity", which means our solution would be completely generalisable.
  + They can often be optimised better on computers

  === Converting cartesian coordinates to homogeneous coordinates
  The generally accepted conversion norm is to set $W=1$ when converting, since the coordinate really remains the same relative to the plane regardless.

  #example[
    $
    mat(3;4) = mat(3;4;1)
    $
  ] where LHS is cartesian and RHS is homogeneous coordinates.

  == Projective Transforms
  Indeed, we must find an alternative system of matrices which lets us change which lines are parallel.
  
  As an example, consider the use of Field Of View(FOV) in games or cameras, where we can imagine a mapping of an entire plane to another plane.
  
  Furthermore, the desired transformation can be described as a change in perspective. One can imagine looking at the arbitrary quadrilateral from another point to observe a rectangle. Hence, such a mapping between planes could be thought of as simply passing through a point. In fact, this is the mathematical representation of any pinhole-like camera. This can be visualised as below:
  #figure(
    cetz.canvas(length: 3cm, {
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
    line((0, 0), (1,0.3))
    line((0.1, -0.9), (0.7,-1.2))
    line((0,0), (0.7,-1.2))
    line((1,0.3), (0.1,-0.9))
    line((0.3, 0.09), (0.34,-0.6))
    line((0.34, -0.6), (0.37, -1.04))
    content((0,0), "Plane 1", anchor: "east")
    content((0.1,-0.9), "Plane 2", anchor: "east")
    content((0.3, 0.25), $p_1$, anchor: "south")
    content((0.44, -0.6), $T$, ancor: "west")
    content((0.37, -1.04), $p_2$, anchor: "south")
  }),
    caption: "Projective Transforms"
  )<projective_transform>
]