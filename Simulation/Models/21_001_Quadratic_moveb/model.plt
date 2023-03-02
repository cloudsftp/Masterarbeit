mod(a, b) = a - (floor(a/b) * b)

r(x)  = mod(x       , 2 * 3)
s(x)  = mod(r(x)    , 3)
tL(x) = s(x) - 3. / 4
tR(x) = s(x) - 3 * 3. / 4

h(x) =  (s(x) < z)  ? aL * tL(x) * tL(x) + bL * tL(x) + cL \
                    : aR * tR(x) * tR(x) + bR * tR(x) + cR

g(x) =  (r(x) < 3)  ? h(x) : h(x) + 3
f(x) =  mod(g(x), 2 * 3)
