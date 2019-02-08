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
