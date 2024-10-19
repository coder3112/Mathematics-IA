#import "template.typ": example

#let matrices = [
= Matrices
A matrix(pl: matrices) is a 2-D Array, described by the notation $m times n$ where $m$ is the number of rows and columns. For example, this is a 2 x 2 matrix:
$
mat(
  1, 10;
  2, 4;
)
$
$M_(i j)$ denotes the element present in row $i$ and column $j$ in matrix $M$.

== Transpose of a matrix
A tranpose operation on a matrix acts to switch the columns and rows of a matrix. It is represented by a superscript $T$: $A^T$ is the transpose matrix of $A$.
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


]