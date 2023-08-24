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

CARDx = -0.75
CARDy = -1.25

set arrow from L, CARDy + 0.2 to CARDx, CARDy @BorderStyle
set arrow from CARDx, CARDy to CARDx, U @BorderStyle
set label 'CARD' at CARDx, CARDy @PointStyle

CALDx = -1.25
CALDy = 0.65

set arrow from R, CALDy + 0.15 to CALDx, CALDy @BorderStyle
set arrow from CALDx, CALDy to CALDx, U @BorderStyle
set label 'CALD' at CALDx, CALDy @PointStyle

CALUx = 0.75
CALUy = 0.6

set arrow from R, CALUy + 0.3 to CALUx, CALUy @BorderStyle
set arrow from CALUx, CALUy to CALUx, D @BorderStyle
set label 'CALU' at CALUx, CALUy @PointStyle

set label 'CAL' at 1.5, 0.775 @PointStyle

CARUx = 1.25
CARUy = -0.75

set arrow from L, CARUy + 0.3 to CARUx, CARUy @BorderStyle
set arrow from CARUx, CARUy to CARUx, D @BorderStyle
set label 'CARU' at CARUx, CARUy @PointStyle

# type B
color = 'red'

CBLUx = -1
CBLUy = 0.8
CBRUx = 1
CBRUy = 1
CBRDx = 1
CBRDy = -1
CBLDx = -1
CBLDy = -0.8

set arrow from CBLUx, CBLUy to CBRUx, CBRUy @BorderStyle
set arrow from CBRUx, CBRUy to CBRDx, CBRDy @BorderStyle
set arrow from CBRDx, CBRDy to CBLDx, CBLDy @BorderStyle
set arrow from CBLDx, CBLDy to CBLUx, CBLUy @BorderStyle

set label 'CBLU' at CBLUx, CBLUy @PointStyle
set label 'CBRU' at CBRUx, CBRUy @PointStyle
set label 'CBRD' at CBRDx, CBRDy @PointStyle
set label 'CBLD' at CBLDx, CBLDy @PointStyle

# region labels

set label 'Qmk' at 0, 0
set label 'Pmk' at 0, -1.5
set label 'Pmk+1' at 0, 1.5
set label 'Pm-2k' at -1.5,0
set label 'Pm+2k+1' at 1.5,0

plot 1/0 t ''
