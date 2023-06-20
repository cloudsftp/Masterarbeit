
reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/1D_Bif_LDU16' '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final'
aL = 4
bL = 0.5
cL = 0
px = -0.375
py = 0

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/1D_Bif_LDU16/Autogen/Frame_0000/result_fm.eps"

set size square
set border lw 1

L = 0.16825
R = 0.16875
D = 0
U = 1

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/1D_Bif_LDU16/extras.plt'

plot '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/60_Final/1D_Bif_LDU16/Autogen/Frame_0000/bif_cyclic.tna' using 1:3 w dots notitle lc rgb 'blue'
