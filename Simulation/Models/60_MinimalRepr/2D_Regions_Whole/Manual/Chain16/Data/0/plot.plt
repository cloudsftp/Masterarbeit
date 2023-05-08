
reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/2D_Period_Whole_onlyP16' '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final'
aL = 4
bL = 0.5
cL = 0
px = 0
py = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/2D_Period_Whole_onlyP16/Autogen/Frame_0000/result_fm.eps"

set size square
set border lw 1

L = -0.45
R = -0.275
D = 0.15
U = 0.1875

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/2D_Period_Whole_onlyP16/extras.plt'

unset colorbox
set palette rgbformulae 30,31,32
plot '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/2D_Period_Whole_onlyP16/Autogen/Frame_0000/period.tna' using 1:2:3 w dots notitle palette
