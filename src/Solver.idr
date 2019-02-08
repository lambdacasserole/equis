module Equis.Solver


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
