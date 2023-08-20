mod(a, b) = a - (floor(a/b) * b)

gL(x) = aL * x * x + bL * x + cL
gR(x) = aR * x * x + bR * x + cR

g(x) =  (x < 0.25)      ? gL(x) \
                        : gR(x)

f(x) =  mod((x < 0.5)   ? g(x) \
                        : g(x - 0.5) + 0.5, 1)
