reset

aL = 4
bL = -0.5
cL = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output 'illustration_fm.eps'

set size square
set border lw 1

L = 0
R = 1
D = 0
U = 1

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R, 'd1' 0.25, 'd2' 0.5, 'd3' 0.75)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

set label 'fA' at 0.08, 0.25
set label 'fB' at 0.32, 0.5
set label 'fC' at 0.08 + .5, 0.25 + .5
set label 'fD' at 0.32 + .5, 0.55 - .5

set grid xtics

px = -0.35
py = 0.16
load 'model.plt'

set key at 0.28, 0.94
p 1/0 w line lw 2 lc rgb 'blue' t 'fL', f(x) w points ps 0.2 pt 7 lc rgb 'blue' notitle

py = 0.17
load 'model.plt'

set key at 0.28, 0.86
p 1/0 w line lw 2 lc rgb 'purple' t 'fM', f(x) w points ps 0.2 pt 7 lc rgb 'purple' notitle

py = 0.18
load 'model.plt'

set key at 0.28, 0.78
plot 1/0 w line lw 2 lc rgb 'red' t 'fH', f(x) w points ps 0.2 pt 7 lc rgb 'red' notitle, \
    x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
            
