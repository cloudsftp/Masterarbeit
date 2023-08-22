
reset
set loadpath '62_MinimalRepr_Adding'
aL = 1
bL = 0.8
cL = 0
px = -0.395
py = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = 0.08175
R = 0.08275
D = 0
U = 64

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load 'extras.plt'

plot 'period.tna' using 1:2 w p pt 5 ps 0.5 lc rgb 'blue' notitle 
