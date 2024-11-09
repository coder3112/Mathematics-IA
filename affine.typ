#import "@preview/cetz:0.3.0"

#let affine = [
  #set math.mat(delim: "[")
  = Affine Transformations
  == Rotation
  A rotation matrix $R$ is represented by:
  $
  R = mat(
    cos theta, -sin theta;
    sin theta, cos theta
  )
  $  
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
    rotate(z: 45deg)
    line((-1, 1), (0.3, 1))
    content((-1.1,1), $ A $, anchor: "east")
    content((0.4,1), $ B $, anchor: "west")
    line((0.3, 1), (0.9, -0.3))
    content((0.9,-0.4), $ C $, anchor: "north")
    line((0.9, -0.3), (-1.5, 0.1))
    content((-1.5, 0), $ D $, anchor: "north")
    line((-1,1), (-1.5, 0.1))
  }),
    cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    set-style(
      stroke: (thickness: 0.7pt, cap: "round"),
    )
    line((-2.5,0.5), (-2,0.5), mark: (end: "stealth"))
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

  Consider the example of @rotated_output. Here, the second quadrilateral is rotated by 45 degrees. Then, we can just see that the transformation matrix $R$ will be:
  $
  R = mat(
    cos 45 degree, -sin 45 degree;
    sin 45 degree, cos 45 degree
  ) = 
  mat(
    1/sqrt(2),-1/sqrt(2);
    1/sqrt(2),1/sqrt(2)
  )
  $ 

  But, in our original research question, we our only given the final and initial coordinates. So, we must find $theta$, i.e., the angle of rotation.
  
  Of course, we can note here that finding the rotation matrix for a single edge should be enough: all edges must have been rotated by the same angle, and therefore, the same matrix will apply to all of them #footnote("One can note that this is a consequence of a rotation being an affine transformation."). This is also the primary benefit of matrices as tools to find transformations: they can be applied on the plane uniformly.

  $ A D = mat(x_D - x_A; y_D - y_A)\ A'D'= mat(x_(D') - x_(A'); y_(D') - y_(A')) $ Taking the above to be initial and final vectors, then we can treat this as a transformation of the former to the latter. Our choice to use $A D$ is arbitrary $dash$ as discussed above any one edge will work.
  
  $ cos theta &= A dot B \ &= (x_D - x_A)(x_(D') - x_(A')) + (y_D - y_A)(y_(D') - y_(A')) $
  $ sin theta &= norm(A times B) \ &= (x_D - x_A)(y_(D') - y_(A')) - (x_(D') - x_(A'))(y_D - y_A) $
  where $norm(.)$ represents the modulus/norm for the vector.
  Thus, we can rewrite the rotation matrix as:
  $
  R &= mat(
    A dot B, -norm(A times B);
    norm(A times B), A dot B
  ) \ &= mat(
    (x_D - x_A)(x_(D') - x_(A')),#h(15pt), -\((x_D - x_A)(y_(D') - y_(A')) -;
    + (y_D - y_A)(y_(D') - y_(A')),#h(15pt), (x_(D') - x_(A'))(y_D - y_A)\);
    ;;
    (x_D - x_A)(y_(D') - y_(A')) -, ,(x_D - x_A)(x_(D') - x_(A'));
    (x_(D') - x_(A'))(y_D - y_A),, + (y_D - y_A)(y_(D') - y_(A'));
  )
  $

  To confirm that this works, we will use @rotated_output again. The coordinates for the vertices are as follows. 
  $
  A = mat(-1;1) & #h(20pt) A' = mat(-1.41;0) \
  D = mat(-1.5;0.1) & #h(20pt) D' = mat(-1.13;-0.99)\
  \
  $
  The numbers for the transformed points were calculated, and the ones written above are merely approximations: 
  This gives
  $
  R_#text("coordinates") = mat(
    0.751, -0.747;
    0.747,0.751
  )
  $
  The correct matrix is
  $
  R_#text("coordinates") = mat(
    0.707, -0.707;
    0.707,0.707
  )
  $
  We can clearly see that the matrix we got from our formula is almost correct, and we can chalk up the minute differences to calculation error due to approximation.
  This can also be seen here:
  #figure(caption: "Original Quadrilateral and its rotation through 2 different matrices", image("rotated_matrix.png", height: 30%))
  
  // However, computing trigonometric functions would be incredibly hard. Instead, we will use the dot and cross products, since they incorporate that into nicer vector/matrix algebra.

  
  
  // *PLEASE NOTE THAT THE REST OF THE MATH WAS SHOWN IN THE PREVIOUSLY SUBMITTED DRAFT, AND WE DISCUSSED IT IN OUR MEETING. I AM WRITING THE DRAFT IN A NEW DOCUMENT NOW TO INCORPORATE OUR DISCUSSION, WHICH IS WHY THIS DOCUMENT DOES NOT CONTAIN THAT (YET)*
]