
A = 2.1
B = 1.2
C = px

D = 1.1
E = 1.2
F = py

_aL = E + F - D
_aR = B + C - A
_bL = D - F
_bR = A - C
_cL = (3. * D - E + F) / 4.
_cR = (3. * A - B + C) / 4.

mod(a, b) = a - (floor(a/b) * b)

r(x)  = mod(x, 4)
s(x)  = mod(r(x), 2)
tL(x) = s(x) - 1. / 2.
tR(x) = s(x) - 3. / 2.

h(x) =  (s(x) < 1)  ? _aL * tL(x) * tL(x) + _bL * tL(x) + _cL \
                    : _aR * tR(x) * tR(x) + _bR * tR(x) + _cR

g(x) =  (r(x) < 2)  ? h(x) : h(x) + 2
f(x) =  mod(g(x), 2 * 2)
