
reset
aL = 6
aR = 6
bL = -1.5
bR = -4.5
cL = 0
cR = 0
n = 0.5

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = 0.25
R = 0.6
D = 0.25
U = 0.6

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load 'extras.plt'

unset colorbox
set palette rgbformulae 30,31,32
plot 'period.tna' using 1:2:3 w dots notitle palette
