module Equis.Matrix.Arithmetic


import Matrix
import Data.Matrix.Numeric


%access private


||| Hadamard multiplication (element-wise product) of two matrices.
|||
||| @x the first matrix
||| @y the second matrix
export
hadamard : Num a => (x, y : Matrix n m a) -> Matrix n m a
hadamard x y = mapMatrix (\(i, j) => i * j) (zipMatrix x y)


||| Calculates a Gramian matrix.
|||
||| @x the matrix
export
gram : Num a => (x : Matrix n m a) -> Matrix m m a
gram x = (transpose x) <> x


||| Calculates the determinant of a square matrix (including order 1 and 0 matrices).
|||
||| @x the matrix
export
determinant : Neg a => (x : Matrix n n a) -> a
determinant {n = Z} _ = 1
determinant {n = (S Z)} x = scalar x
determinant {n = (S (S _))} x = det x


||| Calculates the matrix of minors for the given square matrix.
|||
||| @x the matrix
export
minors : Neg a => (x : Matrix n n a) -> Matrix n n a
minors {n = Z} _ = []
minors {n = (S _)} x = mapMatrix determinant (minors' x) where
  ||| Generates a matrix of m - 1 × n - 1 submatrices within the given matrix.
  |||
  ||| @x the matrix
  minors' : (x : Matrix (S n) (S m) a) -> Matrix (S n) (S m) (Matrix n m a)
  minors' {n} {m} x = mapMatrix (\(i, j) => subMatrix i j x) (coords (S n) (S m))


||| Calculates the matrix of cofactors for the given square matrix.
|||
||| @x the matrix
export
cofactors : Neg a => (x : Matrix n n a) -> Matrix n n a
cofactors {n} x = hadamard (signs n n False) (minors x) where
  ||| Generates an alternating vector of +1 and -1 of length `n`
  |||
  ||| @n the length of the vector to ganerate
  ||| @b if set to false, the first element will be 1, otherwise it will be -1
  signs' : (n : Nat) -> (b : Bool) -> Vect n a
  signs' Z _ = []
  signs' (S k) False = 1 :: (signs' k True)
  signs' (S k) True = -1 :: (signs' k False)
  ||| Generates an alternating matrix of +1 and -1 of order m × n.
  |||
  ||| @n the first matrix dimension
  ||| @m the second matrix dimension
  ||| @b if set to false, the first element will be 1, otherwise it will be -1
  signs : (n : Nat) -> (m : Nat) -> (b : Bool) -> Matrix n m a
  signs Z m _ = []
  signs (S k) m False = (signs' m False) :: (signs k m True)
  signs (S k) m True = (signs' m True) :: (signs k m False)


||| Calculates the adjugate of the given square matrix.
|||
||| @x the matrix
export
adjugate : Neg a => (x : Matrix n n a) -> Matrix n n a
adjugate x = transpose (cofactors x)


||| Calculates the inverse of the given square matrix (must be of at least order 1).
|||
||| @x the matrix
export
inverse : Neg a => Fractional a => (x : Matrix n n a) -> Matrix n n a
inverse x = (1 / (determinant x)) <#> (adjugate x)


||| Calculates an inverse Gramian matrix.
|||
||| @x the matrix
export
inverseGram : Neg a => Fractional a => (x : Matrix (S n) (S m) a) -> Matrix (S m) (S m) a
inverseGram x = inverse (gram x)
