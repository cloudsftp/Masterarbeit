thetamin = pi / 2
thetamax = 3 * pi / 2
theta = pi

#aL = tan(theta) / tan(thetamin)
#aR = tan(theta) / tan(thetamax)
aL = 0.5
aR = 2 - aL

w = 0.2
xsw = (aR - 1) / (aR - aL)

mod(a, b) = a - (floor(a/b) * b)

a(x) = (x < xsw) ? aL : aR
f(x) = mod(w + a(x) * (x - xsw) + xsw, 1)
