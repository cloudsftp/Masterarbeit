
reset
aL = 8
aR = 1
bL = -1
bR = 0
cL = 0
cR = 0
px = 0.385
py = 0.1675

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

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load 'model.plt'

plot f(x) w points ps 0.3 pt 7 lc rgb 'black' notitle, \
            'cyclic_cobweb.tna' w lines lw 1 lc rgb 'red' notitle, \
            x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
            
