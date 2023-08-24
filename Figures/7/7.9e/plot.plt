reset

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

unset border
unset xtics
unset ytics

set size square
set border lw 1

L = -2
R = 2
D = -2
U = 2

set xrange [L to R]
set yrange [D to U]

BorderStyle="lw 2 dt 1 lc rgb color front nohead"
PointStyle="point pointtype 7 lc rgb color front"

# type A
color = 'blue'

CARDx = -1
CARDy = 0.5

set arrow from L, CARDy to CARDx, CARDy @BorderStyle
set arrow from CARDx, CARDy to CARDx, U @BorderStyle
set label 'CARD' at CARDx, CARDy @PointStyle

CALDx = -0.75
CALDy = -0.25

set arrow from R, CALDy to CALDx, CALDy @BorderStyle
set arrow from CALDx, CALDy to CALDx, U @BorderStyle
set label 'CALD' at CALDx, CALDy @PointStyle

CALUx = 1
CALUy = -0.5

set arrow from R, CALUy to CALUx, CALUy @BorderStyle
set arrow from CALUx, CALUy to CALUx, D @BorderStyle
set label 'CALU' at CALUx, CALUy @PointStyle

CARUx = 0.75
CARUy = 0.25

set arrow from L, CARUy to CARUx, CARUy @BorderStyle
set arrow from CARUx, CARUy to CARUx, D @BorderStyle
set label 'CARU' at CARUx, CARUy @PointStyle


# region labels

set label 'Pmk' at -1, -1
set label 'Pmk+1' at 1, 1.25
set label 'Pm-2k' at -1.5, 1.5
set label 'Pm+2k+1' at 1.5, -1.5

plot 1/0 t ''
