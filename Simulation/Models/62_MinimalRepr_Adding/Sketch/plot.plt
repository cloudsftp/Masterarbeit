reset

aL = 1
bL = 0.5
cL = 0
px = -0.3825
py = 0.085

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = 0
R = 1
D = 0
U = 1

set xrange [L to R]
set yrange [D to U]

load '../model.plt'

set xtics ('L' L, 'R' R, 'd1' 0.25, 'd2' 0.5, 'd3' 0.75)
set ytics ('D' D, 'U' U) rotate by 90

set grid front

set xlabel 'x' offset -5, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

plot    f(x) w points ps 0.3 pt 7 lc rgb 'blue' notitle, \
        x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
