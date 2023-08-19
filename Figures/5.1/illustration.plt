set terminal postscript landscape enhanced color blacktext \
    dashed dashlength 1.0 linewidth 1.0 defaultplex \
    palfuncparam 2000,0.003 \
    butt "Helvetica" 20

set output 'illustration_fm.eps'

set size square
set border lw 1

L = 0
R = 2 * pi
D = 0
U = 2 * pi

set xrange [L to R]
set yrange [D to U]

d0 = 0.26
d1 = 1.04

set xtics ('L' L, 'R' R, 'd0' d0, 'd1' d1, 'd2' d0 + pi, 'd3' d1 + pi)
set ytics ('D' D, 'U' U) rotate by 90

set grid xtics

set xlabel 'x' offset -4, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

set xlabel 'x'
set ylabel 'y'

set label 'FA' at 0.4, 1.4
set label 'FB' at 2.0, 3.5
set label 'FC' at 0.4 + pi, 1.4 + pi
set label 'FD' at 2.0 + pi, 3.5 - pi

plot 'model.dat' w dots notitle lc rgb 'blue'
