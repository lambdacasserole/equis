module Equis.Matrix.Algebraic


import Data.Matrix.Algebraic


%access private


||| Retrieves the scalar value from an order-1 square matrix.
|||
||| @x the matrix
export
scalar : (x : Matrix (S Z) (S Z) a) -> a
scalar x = head (head x)


||| Zips two matrices together pairwise.
|||
||| @x the first matrix
||| @y the second matrix
export
zipMatrix : (x : Matrix n m a) -> (y : Matrix n m b) -> Matrix n m (a, b)
zipMatrix [] [] = []
zipMatrix (x :: xs) (y :: ys) = (zip x y) :: (zipMatrix xs ys)


||| Maps a function over a matrix.
|||
||| @f the function
||| @x the matrix
export
mapMatrix : (f : a -> b) -> (x : Matrix n m a) -> Matrix n m b
mapMatrix f x = map (map f) x


||| Generates a matrix of the specified order containing zero-based coordinates along one dimension.
|||
||| @n the first matrix dimension
||| @m the second matrix dimension
coord : (n : Nat) -> (m : Nat) -> Matrix n m (Fin m)
coord Z (S k) = []
coord (S k) m = (fins m) :: (coord k m)


||| Generates a matrix of the specified order containing zero-based coordinates along both dimensions.
|||
||| @n the first matrix dimension
||| @m the second matrix dimension
export
coords : (n : Nat) -> (m : Nat) -> Matrix n m (Fin n, Fin m)
coords n m = zipMatrix (transpose (coord m n)) (coord n m)
