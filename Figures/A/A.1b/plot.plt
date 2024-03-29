
reset
a = 0.5
b = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = 0.1
R = 0.3
D = 0
U = 10

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R, 'A' 0.2)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

set grid xtics

load 'extras.plt'

plot 'period.tna' using 1:2 w p pt 5 ps 0.5 lc rgb 'blue' notitle 
