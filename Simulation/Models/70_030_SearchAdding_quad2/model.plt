A = hl
B = dl
C = py

D = hr
E = dr
F = -px

_aL = 2 * B + 4 * C - 4 * A
_aR = 2 * E + 4 * F - 4 * D
_bL = 2 * (A - C)
_bR = 2 * (D - F)
_cL = (6 * A - B + 2 * C) / 8
_cR = (6 * D - E + 2 * F) / 8

mod(a, b) = a - (floor(a/b) * b)

s(x)  = mod(x, 1)
tL(x) = s(x) - 1. / 4.
tR(x) = s(x) - 3. / 4.

h(x) =  (s(x) < 0.5) ? _aL * tL(x) * tL(x) + _bL * tL(x) + _cL \
                     : _aR * tR(x) * tR(x) + _bR * tR(x) + _cR

f(x) =  mod(h(x), 1)
