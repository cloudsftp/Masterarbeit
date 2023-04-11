reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final'

aL = 4
bL = 0.5
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

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90



px = -0.35
py = 0.16
load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/model.plt'

p f(x) w points ps 0.2 pt 7 lc rgb 'blue' notitle

py = 0.17
load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/model.plt'

p f(x) w points ps 0.2 pt 7 lc rgb 'purple' notitle

py = 0.18
load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/model.plt'

plot f(x) w points ps 0.2 pt 7 lc rgb 'red' notitle, \
    x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
            