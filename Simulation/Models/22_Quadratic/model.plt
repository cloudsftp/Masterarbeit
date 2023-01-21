mod(a, b) = a - (floor(a/b) * b)

s(x)  = mod(x, 3)
tL(x) = s(x) - 3. / 4
tR(x) = s(x) - 3 * 3. / 4

g(x) =  (s(x) < 3./2)   ? aL * tL(x) * tL(x) + bL * tL(x) + cL \
                        : aR * tR(x) * tR(x) + bR * tR(x) + cR

f(x) = mod(g(x), 3)
