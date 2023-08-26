mod(a, b) = a - (floor(a/b) * b)

h(x) =  (s(x) <= 0.25)  ? a * x + b
                        : a * x - a / 4
g(x) =  (r(x) <= 0.5)   ? h(x)
                        : h(x - 0.5) + 0.5
f(x) =  mod(g(x), 1)
