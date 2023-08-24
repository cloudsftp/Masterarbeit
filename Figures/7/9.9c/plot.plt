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

CARDx = -1.25
CARDy = 0.5

set arrow from L, CARDy to CARDx, CARDy @BorderStyle
set arrow from CARDx, CARDy to CARDx, U @BorderStyle
set label 'CARD' at CARDx, CARDy @PointStyle

CALDx = -1
CALDy = -0.25

set arrow from R, CALDy + 1.0 to CALDx, CALDy @BorderStyle
set arrow from CALDx, CALDy to CALDx, U @BorderStyle
set label 'CALD' at CALDx, CALDy @PointStyle

CALUx = 1.25
CALUy = -0.5

set arrow from R, CALUy + 0.4 to CALUx, CALUy @BorderStyle
set arrow from CALUx, CALUy to CALUx, D @BorderStyle
set label 'CALU' at CALUx, CALUy @PointStyle

CARUx = 1
CARUy = 0.25

set arrow from L, CARUy + 0.7 to CARUx, CARUy @BorderStyle
set arrow from CARUx, CARUy to CARUx, D @BorderStyle
set label 'CARU' at CARUx, CARUy @PointStyle


# region labels

set label 'Pmk' at -1, -1
set label 'Pmk+1' at 0, 1.5
set label 'Pm-2k-1' at -1.7, 1.5
set label 'Pm+2k+1' at 1.6, -1

plot 1/0 t ''
