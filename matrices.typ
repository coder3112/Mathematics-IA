#import "template.typ": example, proof

#let matrices = [
#set math.mat(delim: "[")
= Matrices
A matrix(pl: matrices) is a 2-D Array, described by the notation $m times n$ where $m$ is the number of rows and columns. For example, this is a 2 x 2 matrix:
$
mat(
  1, 10;
  2, 4;
)
$
$M_(i j)$ denotes the element present in row $i$ and column $j$ in matrix $M$.

== Rectangular Matrix
This is a matrix where the number of columns and rows are different.

== Transpose of a matrix
A transpose operation on a matrix acts to switch the columns and rows of a matrix. It is represented by a superscript $T$: $A^T$ is the transpose matrix of $A$.
#example[
  $
  mat(
    1, 10;
    2, 4;
  )^T
  = 
  mat(
    1, 2;
    10, 4;
  )
  $
]

== Symmetric Matrix
A matrix which has the same values across a diagonal line. In other words, $ A = A^T $ for any symmetric matrix $A$.
Such a matrix has eigenvectors which are perpendicular to each other.
#example[
  $
  mat(1,3;3,2)^T = mat(1,3;3,2)
  $
]

== Matrix Arithmetic
=== Multiplying by a scalar
Each entry in the matrix is multiplied by the scalar.
#example[
  $
  8 dot mat(1,1;2,3) = mat(8,8;16,24)
  $
]

=== Multiplying two matrices
For matrix multiplication to be valid, the number of columns in the first matrix must be equal to the number of rows in the second matrix. 
Given
$
A = mat(
  a_11, a_12, dots, a_(1n);
  dots.v, dots.v, dots.down, dots.v;
  a_(m 1), a_(m 2), dots, a_(m n),
)
#text("and")
B = mat(
  b_11, b_12, dots, b_(1n);
  dots.v, dots.v, dots.down, dots.v;
  b_(n 1), b_(n 2), dots, b_(n p),
),
$
#set math.mat(column-gap: 1em)
$
A B = mat(
  a_11 b_11 + dots + a_(1n) b_(n 1), a_11 b_12 + dots + a_(1 n) b_(n 2), dots.c dots.c, a_11 b_(1p) + dots + a_(1 n) b_(n p);
  a_21 b_11 + dots + a_(2n) b_(n 1), a_21 b_12 + dots + a_(2 n) b_(n 2), dots.c dots.c, a_21 b_(1p) + dots + a_(2 n) b_(n p);
  ,dots.v;
  ,dots.v;
  a_(m 1) b_11 + dots + a_(m n) b_(n 1), a_(m 1) b_12 + dots + a_(m n) b_(n 2), dots.c dots.c, a_(m 1) b_(1p) + dots + a_(m n) b_(n p);
)
$
#set math.mat(column-gap: 0% + 0.5em)
That is, $ A B_(i j) = sum_(k=1)^(n) a_(i k) b_(k j)$

== Transformation Matrices
A matrix represents a transformation of points to allow for stretching, squeezing, translation and rotation etc. which change the coordinates of a set of points while preserving a set of properties.

For a transformation $T$ on a point $x$, represented in column-vector form, it can be written as $T(x) = A x$ where $A$ is the transformation matrix of T.

== Eigenvectors and Eigenvalues
An _eigenvector_ of a matrix is a vector whose direction remains unchanged when the matrix is used to transform it. That means, the vector is only scaled by a constant factor. More precisely, if $T$ is the transformation matrix, $v$ is the vector and $lambda$ is the constant scaling vector:
$ T v = v lambda $
The _eigenvalue_ is the corresponding scale factor, $lambda$.

== Singular Values
Consider any rectangular matrix $A$. Then, obtain the matrix $S_L$ and $S_R$ as follows:
$ 
S_L = A dot A^T \
S_R = A^T dot A.
$
These matrices are symmetric.
#proof[
  $ 
  (S_L)^T &= (A A^T)^T = (A^T)^T A^T = A A^T \
  (S_R)^T &= (A^T A)^T = A^T (A^T)^T = A^T A
  $
]

Next, we consider the eigenvectors of each. The eigenvectors of $S_L$ are called the _left singular vectors_. Those of $S_R$ are called _right singular vectors_

Next, we use the fact that $S_L$ and $S_R$ are _Positive Definite Matrices_. This simply implies that if we take their eigenvalues, then:
+ All eigenvalues are non negative, i.e. $lambda gt.eq 0$
+ $S_L$ and $S_R$ have the same(non-zero) negative eigenvalues
  + If we arrange the eigenvalues of both in descending order, then the overlapping ones are identical
  + The eigenvalue(s) remaining without overlap must be 0.
+ Now, if we take the non-zero, shared eigenvalues, say $lambda_i$, then the singular values of the original rectangular matrix are: $ sigma_i = sqrt(lambda_i) $

== Singular Value Decomposition
Any matrix $A$ can be decomposed into three matrices:
$ A = U Sigma V^T $, where
+ $U$ contains the left singular vectors of $A$ in descending order.
+ $V$ contains the right singular vectors of $A$ in descending order. In the SVD, we consider the transpose of this matrix.
+ $Sigma$ is a matrix of the same dimensions as $A$. The numbers on the diagonal are the singular values of $A$, arranged in descending order. All other values are 0. 

This is a very complex operation, and only a short summary is provided above. Indeed, if we use this method, we will use a computer to do the numerical computation for us.
]