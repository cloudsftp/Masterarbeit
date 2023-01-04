load 'common-math.plt'

load 'dimens.plt'

r(x) =  mod(x, 2*pi)
s(x) =  mod(x, pi)
t(x) =  mod(x, pi/2)

h(x) =  (s(x) <= pi/2)  ? a * t(x) + b  : a * t(x)
g(x) =  (r(x) <= pi)    ? h(x)          : h(x) + pi
f(x) =  mod(g(x), 2*pi)
