// #import "template.typ": *;

// #let appendix_b = [
//   #set heading(numbering: none)
//   = Proofs <proofs>
//   == Rotation Matrix <rotmatrixproof>
//   #theorem[
//     The Rotation Matrix is $ mat(cos theta, -sin theta; sin theta, cos theta) $
//     #proof[
//       Use polar co-ordinates with
//       $
//       x = R cos(phi) \
//       y = R sin(phi)
//       $
//       Then, after a rotation of angle $theta$,
//       $
//       x &= R cos (phi + theta) \
//        &= R cos(phi)cos(theta) - R sin(phi)sin(theta)\
//        &= x cos(theta) - y sin(theta)\ \
//       y &= R sin (phi + theta) \
//       &= R sin(phi)cos(theta) + R sin(phi)cos(theta)\
//        &= x sin(theta) + y cos(theta)\ \
//       $
//       This can be translated into the matrix:
//       $
//       mat(
//         cos theta, -sin theta;
//         sin theta, cos theta
//       )
//       $
//     ]
//   ]
//   #properties[
//     Rotations are affine transformations.
//     #proof[
//       All linear transformations are affine @alllinearareaffine, by definition. Hence, a proof that rotations are linear maps is sufficient. Such a proof is provided in @rotationislinear.
//     ]
//   ]

//   == Squeeze Matrix
//   #theorem[
//     The Squeeze Matrix is $ mat(a,0;0,1/a) $
//     #proof[
//       $
//       mat(a,0;0,1/a)mat(x;y) = mat(a x + 0y; 0 x + 1/a y) = mat(a x; y/a)
//       $
//     ]
//   ]
//   #properties[
//     Squeezing is essentially a hyperbolic rotation
//   ]

//   == Scaling Matrix
// ]

