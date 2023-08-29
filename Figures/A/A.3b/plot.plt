
reset
aL = 1
aR = 1
bL = 0
bR = 0
cL = 1
cR = 3
px = 0.7
py = 0.1595

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = 0
R = 6
D = 0
U = 6

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
            
