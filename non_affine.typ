#import "@preview/cetz:0.3.0"

#import "template.typ": example

#let non_affine = [
  = Non Affine Transformations
  We have seen above that affine transformations can help with rotation, scaling etc. but is not helpful in actually converting "shapes". This means, that a trapezium cannot be converted into a rectangle and so on. This is because these shapes have a different set of lines which are parallel $dash$ their axes must be transformed/warped. Non-Affine transformations are the the category of transformations which specifically deal with this issue and will be discussed now.

  However, before that, another problem must be addressed: the chosen coordinate system. In Cartesian Coordinates,  operations such as a change of perspective or translation are represented by matrix _addition_. However, since transformations such as rotation and squeezing happen by matrix _multiplication_, the former and latter cannot be combined into a single matrix. To solve this problem, Homogeneous Coordinates are also introduced.
  
  == Homogeneous Coordinates
  Homogeneous or Projective Coordinates are coordinates that:
  + If they are multiplied by a (non-zero) _scalar_, then the resulting coordinates represent the same point.
  + They allow translation to be represented with matrices the same way scaling and rotation is.
  
  #figure(
    //http://www.songho.ca/math/homogeneous/homogeneous.html
    caption: [Each of the points on the orange line are equivalent in homogeneous coordinates. Source: @songho],
    image("homogeneous_coordinates_example.png", width: 40%),
  )<illustrationhomo>
  
  Imagine projecting a 2D image onto a screen. Then, there are obviously X and Y dimensions of the image. However, there is also a coordinate W, i.e. the distance of the projector from the screen. If it increases, the image gets bigger, and if it decreases, the image gets smaller. 
  
  The (X, Y) coordinates are Cartesian, and adding W into the mix allows us to discuss projective geometry. Hence, in this case we would have (X, Y, W) and these are the homogeneous coordinates. This will help us solve the problem of uniformly representing a transformation. 
  
  This is better than cartesian coordinates for the following causes:
  + Two different planes always intersect at a point
  + A line and a plane (almost) always intersect at a point
  The above two facts are used to ensure that one can change perspective using matrices. Indeed, later, when @projective_transform is considered, it is assumed that the two planes intersect at only one point, and the transformation rays indicated in the figure only pass through once. 
  Furthermore,
  + It can represent cases at "infinity", which means the solution would be completely generalisable for any sort of scaling or distances without having to account for it additionally.
  + They can often be optimised better on computers, which while not a direct requirement, is beneficial, since the original research question arose out of curiosity for how image transformations happen on technology.

  === Converting Cartesian coordinates to homogeneous coordinates <convert_cart_homo>
  The generally accepted conversion norm is to set $W=1$ when converting, since the coordinate really remains the same relative to the plane regardless.

  #example[
    $
    mat(3;4) = mat(3;4;1)
    $
  ] where LHS is cartesian and RHS is homogeneous coordinates.

  == Projective Transforms <projetransform>
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
    content((0.37, -1.14), $p_2$, anchor: "south")
  }),
    caption: "Projective Transforms"
  )<projective_transform>

  Refer back to @projective_transform. Now, we aim to construct a relation between the two planes, $p_1$ and $p_2$.

  Another way to visualise this is like so:
  #figure(image("perspectivetransform.png", height: 30%), caption: [Source: Christopher R. Wren in @Wren_1998])<plane_ray_fig>
  

  Here. $x, y$ represent the initial coordinates on $p_1$, while $X,Y$ represent the final coordinates on $p_2$ after transformation.

  Assume that there exists a $3 times 3$ matrix H that allows the transformation from $p_1$ to $p_2$.
  #math.equation(numbering: "(1)", block: true, [
  $
  p_2 = H dot p_1
  $
  ])<transform_basiceq>

  The following derivation takes inspiration from @Wren_1998. 

  Now, we are going to first convert the Cartesian coordinates $(X, Y)$ and $(x, y)$ from @plane_ray_fig into homogeneous coordinates to take advantage of the features they provide. Since the scaling of a point does not matter in homogeneous coordinates(all of them indicate to the same point as seen in @illustrationhomo), we can actually write with arbitrary $W in RR$ (Note that we implicitly convert $(x,y)$ to homogeneous coordinates as discussed in @convert_cart_homo :
  $
  mat(X W; Y W; W;)
  =
  mat(
    h_11, h_12, h_13;
    h_21, h_22, h_23;
    h_31, h_32, h_33;
  )
  mat(x;y;1)
  $
  However, we can actually simplify this slightly. We are looking for a transformation that changes perspective, i.e. a perspective transform. This is sufficient simply by having the coefficient $h_33$ be 1. (When it is a non-unitary value, it acts to translate bodies but that is obviously not needed here). So,
  $
  mat(X W; Y W; W;)
  =
  mat(
    h_11, h_12, h_13;
    h_21, h_22, h_23;
    h_31, h_32, 1;
  )
  mat(x;y;1)
  $
  Now, we can begin to simplify this matrix to obtain some answers.
  Using matrix multiplication, one has that:
  $ W = h_31 x + h_32 + 1. $
  Also, by simply transposing terms in our equation to get (in other words, the $W$ is "factored out"):
  Dividing the left hand side by $W$ gives $mat(X;Y;1)$. Since we just calculated $W$ in vector form above, we can also substitute that into the division on the right hand side below:
  $
  mat(X;Y;1) = 
  #box[
    $
    mat(
      h_11, h_12, h_13;
      h_21, h_22, h_23;
      h_31, h_32, 1;
    )
    mat(x;y;1)
    $
  ]
    /
    #box[
    $
    mat(h_31,h_32,1)
    mat(x;y;1)
    $
  ]
  $
  In non-vector form, this can simply be written as using matrix multiplication:
  $
  X = #box[
    $
    h_11 x + h_12 y + h_13
    $
  ]
  /
  #box[
    $
    h_31 x + h_32 y + 1
    $
  ]
  \
  Y = #box[
    $
    h_21 x + h_22 y + h_23
    $
  ]
  /
  #box[
    $
    h_31 x + h_32 y + 1
    $
  ]
  $
  Transpose the denominators, and simplify the equations to get:
  $
  X = h_11 x + h_12 y  + h_13 - h_31 X x - h_32 \
  Y = h_21 x + h_22 y + h_23 - h_31 Y x - 1 Y y
  $
  We add in some zero terms for convenience, so that we can build a matrix:
  $
  X = h_11 x + h_12 y  + h_13 - h_21 dot 0 + h_22 dot 0 + h_23 dot 0- h_31 X x - h_32 \
  Y = h_11 dot 0 + h_12 dot 0  + h_13 dot 0 + h_21 x + h_22 y + h_23 - h_31 Y x - 1 Y y
  $ which gives:
  $
  mat(x,y,1,0,0,0,-X x,-X y; 0,0,0,x,y,1,-Y x, -Y y)
  mat(h_11;h_12;h_13;h_21;h_22;h_23;h_31;h_32;1)
  =
  mat(X;Y)
  $
  Of course, this was taking any random points $(X, Y)$ and $(x,y)$. In reality, we have been given 4 points. Consequently, they will make an equation of the form:
  $
  mat(x_1,y_1,1,0,0,0,-X_1 x_1,-X_1 y_1; 0,0,0,x_1,y_1,1,-Y_1 x_1, -Y_1 y_1;dots.v;x_4,y_4,1,0,0,0,-X_4 x_4,-X_4 y_4; 0,0,0,x_4,y_4,1,-Y_4 x_4, -Y_4 y_4;)
  mat(h_11;h_12;h_13;h_21;h_22;h_23;h_31;h_32;1)
  =
  mat(X_1;Y_1;dots.v;X_4;Y_4)
  $
  Now, if we solve this equation, we will find the matrix $H$, and we will have our solution.

  == Solving
  The simplest way to solve this would be to solve like a regular algebraic equation.
  $
  &A H' = B \
  arrow.double &A^T A H' = A'T B \
  arrow.double &H' = (A^T A)^(-1) A^T B
  $
  We know A and B. The $X^(-1)$ means the inverse of a matrix $X$, and can be calculated using a computer. However, not all matrices are invertible, and this method would also not be the most accurate due to some approximations having to be made.\ 
  #line(stroke: rgb(0,0,0).lighten(60%), length: 100%)
   Therefore, we can instead use Singular Value Decomposition as 
  described in @svd. 
  $ #text("SVD") P = U Sigma V^T $ The last singular vector of $V$ is the solution to $H$, and then we have the homography matrix to find any transformation:
  $
  h = mat(
      h_11, h_12, h_13;
      h_21, h_22, h_23;
      h_31, h_32, 1;
    )
  $
  SVD has 0 error for the described case, which makes it perfect and is thus the best option.

  == Example
  Then, we are able to generate a mapping between two quadrilaterals. To confirm that this works, sets of points were created inside the original quadrilateral and mapped to the final rectangle using the same homography matrix that was calculated as the mapping. 

  The process started with the word "Hi" inscribed inside a trapezium, and specified an output rectangle to which we needed to construct the transformation matrix. Then, the above method was used, specifically using the vertices of the trapezium as the initial coordinates and the rectangle's coordinates as the final ones. This gave a homography matrix, which is now applied to the word "Hi" by using each point's coordinates and multiplying them by the homography (transformation) matrix to obtain the coordinates for the word in the rectangle. (The original points are red, and the final points are blue.)

  
  The result is as follows:
  #figure(
    grid(
      columns: 2,
      figure(
        image("final.png", height: 55%)
      ),
      figure(
        image("final2.png", height: 55%)
      ),
    ),
    caption: "Homography matrix calculated using Inverse and SVD respectively"
  )<finfinalfinal>

  
  We can see that the final rectangle we obtain is rotated $90 degree$ clockwise, but this is easily fixable as we saw in @rot. This probably happened because the points $A, B, C, D$ were not assigned in order in the code, and is easily fixed. We see here that the difference between the inverse and SVD methods are negligible, but they can play a role in other cases. Therefore, SVD is recommended, as shown in the example above.

  
  = The Process and Introspection thereof
  My first instinct for designing a solution to the research question was to follow a algorithmic procedure I designed myself. I would take one edge and then transform that edge into the desired coordinates, iteratively using the new coordinates to design transformations. However, I quickly realised that this was impossible to implement generally, since each shape is different and we only ended up with a mathematical representation virtually equivalent to being given the old and new coordinates -- information we already had. Furthermore, there as no way to actually use this method to crop images -- it would only work for a given quadrilateral, which while technically a solution to the research question, was unsatisfying on account of it not being a remedy to the original problem of image-editing and game-rendering that this exploration was inspired by. This is where I realised that to improve on the shortcoming of the first method, I needed:
  + A way to uniformly represent our coordinates such that the transformation remains the same for all points on the plane.
  + A transformation that remains constant for all points
  + A transformation of one point that does not depend on another point's position
  To achieve all of this, I decided matrices were the best option. The graphing of functions and their transformation by a 2D column vector $mat(x;y)$ had shown me how much information could be encoded in even the simplest matrix. Thus, I started to try and find a combination of rotations and squeezes that could solve the problem. But of course, affine transformations are only half the puzzle. They are extremely nice and satisfying for simple changes, but for the conversions of arbitrary shapes, it was not possible. Therefore, for non-affine transformations, I initially began by just using Cartesian coordinates, but I realised that homogenous coordinates were far better because of their ability to encode perspective with a single value. They would also be useful in adding translation directly to the matrix, which is needed when the coordinates for the final rectangle could be anywhere. Then, I was able to with some manipulation and effort, obtain the results indicated elsewhere on the internet and my references. 

  During the entire process, I aimed to include as many proofs as possible, to ensure that my answer was "rigourously" derived, as is the nature of Mathematics. I am quite pleased that this was possible, and am also proud of the code I used to create the examples and graphics demonstrations needed; not only did it help the exploration be more clear, it helped me ensure that my derivations were actually correct. 

  Despite this, I think some flaws still persist in the final solution. I did not prove that the method of using a "homography matrix" is applicable to any arbitrary convex quadrilateral, but rather assumed this would be the case as a corollary of the fact that the matrix acts as a transformation between any two planes. While this seems correct, it would be more satisfying to be able to prove correctness in a blanket statement. Another limitation is that I restricted my study to convex quadrilaterals, because concave quadrilaterals often follow patterns unlike those found in convex shapes. I would like to furter investigate in the future whether my solution holds truly generally, and if not, what changes might be made so that this is possible.

  Nevertheless, my research question was answered fully, and I thus believe this investigation  to be success. 
  
  = Conclusion
  Looking at our example above, we can see that we have found a method for finding $T$ in @researchquestion (reproduced below), and have thus answered the research question. 
  
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
    line((2.2,0.5), (3.3,0.5), mark: (end: "stealth"))
    content((2.7,0.76), $T$, anchor: "south")
  }),
    cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    set-style(
      stroke: (thickness: 0.7pt, cap: "round"),
    )
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
  }),
  ),
  )
  Given the coordinates for
  - $A B C D$ with vertices at $A(x_A, y_A)$, $B(x_B, y_B)$, $C(x_C, y_C)$, $D(x_D, y_D)$
  - $A'B'C'D'$ with vertices at $A'(x_A', y_A')$, $B'(x_B', y_B')$, $C'(x_C', y_C')$, $D'(x_D', y_D')$
  Then,
  $
  mat(
    x_A,y_A,1,0,0,0,-x_(A') x_A,-x_(A') y_A;; 0,0,0,x_A,y_A,1,-Y_A x_A, -Y_A y_A;;
    x_B,y_B,1,0,0,0,-x_(B') x_B,-x_(B') y_B;; 0,0,0,x_B,y_B,1,-y_(B') x_B, -y_(B') y_B;;
    x_C,y_C,1,0,0,0,-x_(C') x_C,-x_(C') y_C;; 0,0,0,x_C,y_C,1,-y_(C') x_C, -y_(C') y_C;;
    x_D,y_D,1,0,0,0,-x_(D') x_D,-x_(D') y_D;; 0,0,0,x_D,y_D,1,-y_(D') x_D, -y_(D') y_D;
  )
  
  mat(h_11;;h_12;;h_13;;h_21;;h_22;;h_23;;h_31;;h_32;;1)
  =
  mat(x_(A');;Y_A;;x_(B');; y_(B');; x_(C');; y_(C');; x_(D');; y_(D');)
  $ as shown in @projetransform. This can be solved using either of the techniques described above: using SVD or through Matrix Inverse. 

  Finally, the matrix to transform is:
  $
  T = mat(
      h_11, h_12, h_13;
      h_21, h_22, h_23;
      h_31, h_32, 1;
    )
  $
]