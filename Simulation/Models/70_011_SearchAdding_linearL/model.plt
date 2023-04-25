A = -px
B = 1.05

_bL = bL
_cL = py

_bR = (B - A) * 2.
_cR = (A + B) / 2.

mod(a, b) = a - (floor(a/b) * b)

s(x)  = mod(x, 1)
tL(x) = s(x) - (1. / 4.)
tR(x) = s(x) - (3. / 4.)

h(x) =  (s(x) < 0.5)    ? _bL * tL(x) + _cL \
                        : _bR * tR(x) + _cR

f(x) =  mod(h(x), 1)
