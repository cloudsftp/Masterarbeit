
A = -px
B = 0.525

_aL = aL
_bL = bL
_cL = cL + py

_bR = 4. * (B - A)
_cR = (2. * A) - B

mod(a, b) = a - (floor(a/b) * b)

s(x) =  mod(x, 0.5)

h(x) =  (s(x) < 0.25)   ? _aL * s(x) * s(x) + _bL * s(x) + _cL \
                        : _bR * s(x) + _cR

g(x) =  (x < 0.5)   ? h(x) : h(x) + 0.5
f(x) =  mod(g(x), 1)
