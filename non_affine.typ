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
]