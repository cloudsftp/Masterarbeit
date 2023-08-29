mod(a, b) = a - (floor(a/b) * b)

h(x) =  (x <= 0.25)     ? a * x + b \
                        : a * x - a / 4
g(x) =  (x <= 0.5)      ? h(x) \
                        : h(x - 0.5) + 0.5
f(x) =  mod(g(x), 1)
