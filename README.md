# Equis
A library for solving systems of linear equations, using Idris.

![Logo](assets/logo.svg)

## Overview
Sometimes we need to solve systems of linear equations like the following:

```
x + y + z = 6
2y + 5z = −4
2x + 5y − z = 27
```

Using this library, we can do so in Idris:

```idris
> :exec solve [[1.0, 1.0, 1.0], [0.0, 2.0, 5.0], [2.0, 5.0, -1.0]] [6.0, -4.0, 27.0]
[5, 3, -2]
```

This is the same system of linear equations used over on [Maths is Fun](https://www.mathsisfun.com/algebra/matrix-inverse.html) so you can check the solution over there if you don't believe me. The library uses the same well-known approach detailed in that tutorial.

If we attempt to solve a system for which there is no solution, we will get `nan` back:

```
> :exec solve [[1.0, 1.0, 1.0], [1.0, 1.0, 1.0]] [6.0, 9.0]
[nan, nan, nan]
```

## References
* Pierce, Rod,  2018, 'Solving Systems of Linear Equations Using Matrices', Math Is Fun, Available at: <http://www.mathsisfun.com/algebra/systems-linear-equations-matrices.html>. [Accessed 8 Feb 2019]
