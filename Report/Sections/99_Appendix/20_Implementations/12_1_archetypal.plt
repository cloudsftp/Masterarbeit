A = -px
B = 0.525

_aL = aL
_bL = bL
_cL = cL + py

_bR = 4. * (B - A)
_cR = (2. * A) - B

mod(a, b) = a - (floor(a/b) * b)

l(x) =  _aL * x * x + _bL * x + _cL 
r(x) =  _bR * x + _cR
h(x) =  (x < 0.25) ? l(x) : r(x)

g(x) =  (x < 0.5) ? h(x) : h(x - 0.5) + 0.5
f(x) =  mod(g(x), 1)
