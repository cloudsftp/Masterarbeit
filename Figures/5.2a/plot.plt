
reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/2D_Period_Zoomed_Effects' '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus'
E0 = 16.8
hi = 0.447
mu = 0.5

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/2D_Period_Zoomed_Effects/Autogen/Frame_0000/result_fm.eps"

set size square
set border lw 1

L = 14
R = 20
D = 0.1
U = 0.35

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/2D_Period_Zoomed_Effects/extras.plt'

unset colorbox
set palette rgbformulae 30,31,32
plot '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/2D_Period_Zoomed_Effects/Autogen/Frame_0000/period.tna' using 1:2:3 w dots notitle palette
