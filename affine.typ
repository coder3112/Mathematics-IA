#import "@preview/cetz:0.3.0"
#import "template.typ": example, proof, theorem

#let affine = [
  #set math.mat(delim: "[")
  = Affine Transformations
  == Rotation <rot>
  A rotation matrix $R$ is represented by:
  $
  R = mat(
    cos theta, -sin theta;
    sin theta, cos theta
  )
  $
  #proof[
      Use polar co-ordinates with
      $
      x = R cos(phi) \
      y = R sin(phi)
      $
      Then, after a rotation of angle $theta$,
      $
      x &= R cos (phi + theta) \
       &= R cos(phi)cos(theta) - R sin(phi)sin(theta)\
       &= x cos(theta) - y sin(theta)\ \
      y &= R sin (phi + theta) \
      &= R sin(phi)cos(theta) + R sin(phi)cos(theta)\
       &= x sin(theta) + y cos(theta)\ \
      $
      This can be translated into the matrix:
      $
      mat(
        cos theta, -sin theta;
        sin theta, cos theta
      )
      $
  ]
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
  
  To calculate $cos(theta)$:
  $
  A D dot A'D' &= norm(A D)norm(A'D')cos(theta) \
  cos(theta) &= frac(A D dot A'D',norm(A D)norm(A'D'))\
  &= frac(A D dot A'D',norm(A D)^2) \
  &= frac((x_D - x_A)(x_(D')-x_(A'))+(y_D - y_A)(y_(D')-y_(A')), (x_D - x_A)^2 + (y_D-y_A)^2)
  $
  Now, to calculate $sin(theta)$
  $
  A D times A'D' &= norm(A D)norm(A'D')sin(theta) \
  sin(theta) &= frac(A D times A'D',norm(A D)norm(A'D'))\
  &= frac(A D times A'D',norm(A D)^2) \
  &= frac((x_D - x_A)(y_(D') - y_(A'))-(y_D - y_A)(x_(D')-x_(A')), (x_D - x_A)^2 + (y_D-y_A)^2)
  $
  Now, we can simply substitute these values into the rotation matrix above to get our answer.
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
    0.690, -0.674;
    0.674,0.690;
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
  #figure(caption: "Original Quadrilateral and its rotation through 2 different matrices", image("rotated_matrix.png", height: 56%))<rotmatfig>

  
  == Squeezing
  This is a simple transformation that preserves area, and "squeezes" the shape such that its width and height are increased proportionally.
  It is represented by the matrix:
  $
  T = mat(
    a, 0;
    0, 1/a;
  )
  $
  #proof[
      $
      mat(a,0;0,1/a)mat(x;y) = mat(a x + 0y; 0 x + 1/a y) = mat(a x; y/a)
      $ which is the desired output vector. (Scaled up and down in orthogonal directions by the same factor)
  ]
  #example[
    #figure(
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
      rect((3,1),(1,0))
      content((3,1), $B$, anchor: "west")
      content((1,0), $D$, anchor: "east")
      content((3,0), $C$, anchor: "west")
      content((1,1), $A$, anchor: "east")
      line((3.5,0.5), (5.5,0.5), mark: (end: "stealth"))
      rect((6,1),(7.5,-0.33))
      content((5.6,1), $A'$, anchor: "west")
      content((6,-0.33), $D'$, anchor: "east")
      content((7.5,-0.33), $C'$, anchor: "west")
      content((7.9,1), $B'$, anchor: "east")
      }),
      caption: "A squeeze mapping"
    )<squeeze_output>
  ]
  In @squeeze_output, a rectangle is transformed as follows:
  $
  A = (1,1) #h(20pt) & A' = (0.75,1.33)\
  B = (3,1) #h(20pt) & B' = (2.25,1.33)\
  C = (3,0) #h(20pt) & C' = (2.25,0)\
  D = (1,0) #h(20pt) & D' = (0.75, 0)\
  $
  Both rectangles have an area of $2 #text(" cm")^2$, and the length and width have been scaled to $75%$ and $133%$, i.e. $3/4$ and $4/3$ respectively. We see, since this has been done in proportion, this is a squeeze mapping.

  Thus, our "squeeze factor" $a$, is $3/4$. The transformation matrix $T$ will be:
  $
  T = mat(
    frac(3,4),0;
    0,frac(4,3)
  )
  $
  Indeed, we can confirm this by simple matrix multiplication. This was done on a computer, and the result is shown below:
  #v(-13pt)
  #figure(
    caption: "Squeeze matrix confirmation", image("squeeze_matrix.png", width: 84%)
  )<squeeze_output_mat>

  == Scaling
  This transformation enlarges or shrinks the distances by a constant factor in both directions.

  The matrix to transform is:
  $
  T = mat(
    a, 0;
    0, a
  )
  $
  #proof[
      $
      mat(a,0;0,a)mat(x;y) = mat(a x + 0y; 0 x + a y) = mat(a x; a y)
      $ which is the desired output vector. (Scaled up in both directions by the same factor)
  ]
  #example[
    #figure(
      cetz.canvas(length: 0.85cm, {
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
      rect((3,1),(1,0))
      content((3,1), $B$, anchor: "west")
      content((1,0), $D$, anchor: "east")
      content((3,0), $C$, anchor: "west")
      content((1,1), $A$, anchor: "east")
      line((3.5,0.5), (5.5,0.5), mark: (end: "stealth"))
      rect((6,1),(10,-1))
      content((6,1), $A'$, anchor: "east")
      content((6,-1), $D'$, anchor: "east")
      content((10,-1), $C'$, anchor: "west")
      content((10,1), $B'$, anchor: "west")
      }),
      caption: "A scaling mapping"
    )<scale_output>
  ]
  In @scale_output, we scale the quadrilateral by a factor of 2. This means both the length and width are 2 times the original in the final quadrilateral.
  The coordinates are as follows:
  $
  A = (1,1) #h(20pt) & A' = (2,2)\
  B = (3,1) #h(20pt) & B' = (6,2)\
  C = (3,0) #h(20pt) & C' = (6,0)\
  D = (1,0) #h(20pt) & D' = (2, 0)\
  $
  So, our matrix for transformation is:
  $
  T = mat(
    2,0;
    0,2;
  )
  $
  We can also confirm this with matrix multiplication on the computer:
  #figure(caption: "Scaled matrix confirmation", image("scale_matrix.png", height: 42%))<scale_output_mat>

  == Combination of Affine Transforms
  Finally, one can combine the above transformations through matrix multiplication in order to obtain a more complex affine transform. For instance, if a shape were to be transformed such that it was was scaled by a factor of 2 and rotated by 45 degrees, we would simply use the transformation matrix:
  $
  T = mat(0.707, -0.707; 0.707, 0.707) mat(2,0;0,2) = mat(1.414,-1.414;1.414,-1.414)
  $

  == Evaluation   
  At this point, some specific cases have been solved. For instance, it is trivial to crop a rectangle into a square; this is just a squeeze matrix. Similarly if the only intention is to zoom into a shot, one can use the scaling matrices. Thereforem this endeavour is still quite useful. Another positive is that these matrices are extremely simple to compute.

  However, no matter how many shears or squeezes are performed by such a combination, it is impossible to convert between two completely distinct shapes such as a trapezium and rectangle through only affine transformations. This method has an intrinsic flaw in that it must always preserve parallel lines. Instead, alternative matrices that do not have this property must be found. Our research question thus remains unanswered for any pair of quadrilaterals.
]