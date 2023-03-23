
A = -px
B = 0.525

_aL = aL
_bL = bL
_cL = cL + py

_bR = (B - A) * 4.
_cR = (A + B) / 2.

mod(a, b) = a - (floor(a/b) * b)

r(x)  = mod(x, 1)
s(x)  = mod(r(x), 0.5)
tL(x) = s(x) - (1. / 8.)
tR(x) = s(x) - (3. / 8.)

h(x) =  (s(x) < 0.25)   ? _aL * tL(x) * tL(x) + _bL * tL(x) + _cL \
                        : _bR * tR(x) + _cR

g(x) =  (r(x) < 0.5)  ? h(x) : h(x) + 0.5
f(x) =  mod(g(x), 1)
