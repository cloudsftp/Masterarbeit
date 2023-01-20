mod(a, b) = a - (floor(a/b) * b)

r(x)  = mod(x, 2*pi)
s(x)  = mod(x, pi)
tL(x) = s(x) - pi / 4
tR(x) = s(x) - 3 * pi / 4

h(x) =  (s(x) < pi/2)   ? aL * tL(x) * tL(x) + bL * tL(x) + cL \
                        : aR * tR(x) * tR(x) + bR * tR(x) + cR

g(x) =  (r(x) < pi)     ? h(x) : h(x) + pi
f(x) =  mod(g(x), 2*pi)
