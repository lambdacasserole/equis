module Equis.Regression.LeastSquares


import Matrix.Numeric
import Data.Matrix.Numeric


%access private


||| Solves a system of linear equations.
|||
||| @coeff the matrix of coefficients
||| @sols the solutions
export
solve : Neg a => Fractional a => (coeff : Matrix (S n) (S n) a) -> (sols : Vect (S n) a) -> Vect (S n) a
solve coeff sols = (inverse coeff) </> sols


||| Calculates a length-n vector of powers of some number, smallest power first.
|||
||| @ord the length of the vector to calculate
||| @x the number
powers : Num a => (ord : Nat) -> (x : a) -> Vect (S ord) a
powers ord x = reverse (powers' ord x) where
  ||| Calculates a length-n vector of powers of some number, largest power first.
  |||
  ||| @ord the length of the vector to calculate
  ||| @x the number
  powers' : (ord : Nat) -> (x : a) -> Vect (S ord) a
  powers' Z _ = 1
  powers' (S Z) x = [x, 1]
  powers' (S k) x = let y@(n :: _) = powers' k x in (n * x) :: y


||| Performs least-squares polynomial fitting on the given independent and dependent values, returning the resulting
||| coefficients.
|||
||| @ord the order of the polynomial
||| @ind the values of the independent variable
||| @dep the values of the dependent variable
export
leastSquares : Neg a => Fractional a => (ord : Nat) -> (ind : Vect (S n) a) -> (dep : Vect (S n) a) -> Vect (S ord) a
leastSquares ord ind dep = leastSquares' (map (powers ord) ind) dep where
  ||| Performs least-squares polynomial fitting on the given independent and dependent values, returning the resulting
  ||| coefficients.
  |||
  ||| @ind the values of the independent variable
  ||| @dep the values of the dependent variable
  leastSquares' : (ind : Matrix (S n) (S m) a) -> (dep : Vect (S n) a) -> Vect (S m) a
  leastSquares' ind dep = ((inverseGram ind) <> (transpose ind)) </> dep


||| Performs least-squares polynomial fitting on the given independent and dependent values, returning the resulting
||| function.
|||
||| @ord the order of the polynomial
||| @ind the values of the independent variable
||| @dep the values of the dependent variable
export
leastSquaresFn : (ord : Nat) -> (ind : Vect (S n) Double) -> (dep : Vect (S n) Double) -> (Double -> Double)
leastSquaresFn ord ind dep = (\i => sum (zipWith (*) (powers ord i) (leastSquares ord ind dep)))
