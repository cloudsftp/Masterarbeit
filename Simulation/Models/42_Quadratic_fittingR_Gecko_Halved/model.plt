
A = px
B = 0.525
C = 1.2

_aL = aL
_aR = (16 * A - 16 * B + 4 * C)
_bL = bL
_bR = (-16 * A + 16 * B - 3 * C)
_cL = cL + py
_cR = (4 * A - 3 * B + C / 2)

mod(a, b) = a - (floor(a/b) * b)

g(x) =  (x < 0.25)      ? _aL * x * x + _bL * x + _cL \
                        : _aR * x * x + _bR * x + _cR

f(x) =  mod((x < 0.5)   ? g(x) \
                        : g(x - 0.5) + 0.5, 1)
