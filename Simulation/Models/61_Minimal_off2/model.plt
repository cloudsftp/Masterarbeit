_aL = aL
_bL = bL
_cL = py

_bR = bR
_cR = -px

mod(a, b) = a - (floor(a/b) * b)

l(x) =  _aL * x * x + _bL * x + _cL 
r(x) =  _bR * x + _cR
h(x) =  (x < 0.25) ? l(x) : r(x)

g(x) =  (x < 0.5) ? h(x) : h(x - 0.5) + 0.5
f(x) =  mod(g(x), 1)
