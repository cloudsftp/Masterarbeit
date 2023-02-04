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

plot 'Autogen/Frame_0000/model.dat' w dots notitle lc rgb 'blue', \
    'Autogen/Frame_0012/model.dat' w dots notitle lc rgb 'purple', \
    'Autogen/Frame_0020/model.dat' w dots notitle lc rgb 'red'
