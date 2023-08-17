reset

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output 'result_fm.eps'

set size square
set border lw 1

L = 0.09032100845
R = 0.09032100855
D = 0
U = 128

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

AAABAAB = L + 0.00000000005
lborder = 9.032100849418140e-02
rborder = 9.032100850655218e-02

set arrow from AAABAAB,D to AAABAAB,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'AAABAAB' at AAABAAB,U offset 0.5, -1.5

set arrow from rborder,D to rborder,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from lborder,D to lborder,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

plot 'Data/period.tna' using 2:3 w dots notitle lc rgb 'blue'
