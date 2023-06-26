reset
set loadpath 'Data' '..' '../..'
aL = 1.0
bL = 0.8
cL = 0
px = -0.39
py = 0.082

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output 'result_fm.eps'

set size square
set border lw 1

L = -0.5
R =  1.5
D = -0.5
U =  1.5

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load 'extras.plt'

# Model
A = -px
B = 0.525

_aL = aL
_bL = bL
_cL = cL + py

_bR = 4. * (B - A)
_cR = (2. * A) - B

l(x) =  _aL * x * x + _bL * x + _cL 
r(x) =  _bR * x + _cR
h(x) =  (x < 0.25) ? l(x) : r(x)

o(x) =  floor(x / 0.5) * 0.5
g(x) =  h(x - o(x)) + o(x)
f(x) =  g(x)
# Model end

# Cobweb
CobLine = "lc rgb 'red' nohead front"
x = 0.02095057480174600 - .5
set arrow from L, x to x, x @CobLine
do for [t=0:26] {
    y = f(x)
    set arrow from x, x to x, y @CobLine
    set arrow from x, y to y, y @CobLine
    x = y
}
set arrow from x, x to x, U @CobLine

# Halved Model
HalvedModel = "dt 3 lc rgb 'red' nohead front"
x = -0.5
do for [t=0:3] {
    y = x + 0.5
    set arrow from x, x to x, y @HalvedModel
    set arrow from x, x to y, x @HalvedModel
    set arrow from y, y to x, y @HalvedModel
    set arrow from y, y to y, x @HalvedModel
    x = y
}

# Full model
FullModel = "dt 3 lc rgb 'blue' nohead front"
set arrow from 0, 0 to 0, 1 @FullModel
set arrow from 0, 1 to 1, 1 @FullModel
set arrow from 1, 0 to 1, 1 @FullModel
set arrow from 1, 0 to 0, 0 @FullModel

set arrow from L, 0 to 0, 0 @FullModel
set arrow from 0, 0 to 0, D @FullModel

set arrow from R, 1 to 1, 1 @FullModel
set arrow from 1, 1 to 1, U @FullModel

#set terminal wxt

# Function and x=y line
plot f(x) w points ps 0.3 pt 7 lc rgb 'black' notitle, \
    x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
