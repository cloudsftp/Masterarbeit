
reset
aL = 1
bL = 0.5
cL = 0
px = 0
py = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

L = -0.45
R = -0.3
D = 0.075
U = 0.12

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90


plot 'Data/0/regions_period.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/regions_period.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/regions_period.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/regions_period.tna' u 2:1 w dots lc rgb 'red' notitle, \
    'Data/4/period.tna' u 2:($3==18 ? $1 : 1/0) w d lc rgb "#FF6E00" notitle, \
    'Data/4/period.tna' u 2:($3==16 ? $1 : 1/0) w d lc rgb "#31A3C6" notitle
