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

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

set xlabel 'x'
set ylabel 'y'

set label 'FA' at 0.4, 1.4
set label 'FB' at 2.0, 3.5
set label 'FC' at 0.4 + pi, 1.4 + pi
set label 'FD' at 2.0 + pi, 3.5 - pi

set key at 0.65*pi, 1.9*pi spacing 1.5

plot    1/0 w line lw 2 lc rgb 'blue' t 'FL', 'model1.dat' w dots notitle lc rgb 'blue', \
        1/0 w line lw 2 lc rgb 'purple' t 'FM', 'model2.dat' w dots notitle lc rgb 'purple', \
        1/0 w line lw 2 lc rgb 'red' t 'FR', 'model3.dat' w dots notitle lc rgb 'red'
