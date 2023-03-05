border = 1.5 - 0.1 * py

_aL = aL
_aR = aR + 2 * px
_bL = bL
_bR = bR + px
_cL = cL + py
_cR = cR

mod(a, b) = a - (floor(a/b) * b)

r(x)  = mod(x       , 2 * 3)
s(x)  = mod(r(x)    , 3)
tL(x) = s(x) - 3. / 4
tR(x) = s(x) - 3 * 3. / 4

h(x) =  (s(x) < 1.5)    ? _aL * tL(x) * tL(x) + _bL * tL(x) + _cL \
                        : _aR * tR(x) * tR(x) + _bR * tR(x) + _cR

g(x) =  (r(x) < 3)  ? h(x) : h(x) + 3
f(x) =  mod(g(x), 2 * 3)
