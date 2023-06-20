
reset

set macros
BoxStyle ="nohead front lt 1 lw 1 dt 1 lc rgb 'navy'"
BoxStyleW="nohead front lt 1 lw 10 dt 1 lc rgb 'white'"
BoxStyle2="nohead front lt 1 lw 2 dt 2 lc rgb 'navy'"

aL = 4
bL = -0.5
cL = 0
px = -0.379
py = 0.16865

set loadpath '../../'

load "model.plt"

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 0.5 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1
unset key 
set samples 6000

eps=0.05
L = -eps
R =  1+eps
D = L
U = R


set xrange [L to R]
set yrange [D to U]

set xtics ('L' 0, 'R' 1) nomirror
set ytics ('D' 0, 'U' 1) rotate by 90 nomirror

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90



#--------------- grid lines at d0, ... d3

set arrow from L,0 to R,0 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from L,1 to R,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

X=0
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.25
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.5
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.75
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=1
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front


#--------------- large blowup box

LL=0.157
RR=0.17
DD=LL
UU=RR

set arrow from LL,DD to LL,UU @BoxStyle
set arrow from LL,UU to RR,UU @BoxStyle
set arrow from RR,UU to RR,DD @BoxStyle
set arrow from RR,DD to LL,DD @BoxStyle

dX=-0.19
dY=0.475
set arrow from LL,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX= 0.19
dY=0.475
set arrow from RR,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front


#--------------- small blowup box at d1

LL2=0.24
RR2=0.26
DD2=0
UU2=0.02

set arrow from LL2,DD2 to LL2,UU2 @BoxStyle
set arrow from LL2,UU2 to RR2,UU2 @BoxStyle
set arrow from RR2,UU2 to RR2,DD2 @BoxStyle
set arrow from RR2,DD2 to LL2,DD2 @BoxStyle

dX=0.057
dY=0.225
set arrow from LL2,UU2 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX= 0.185
dY=0.095
set arrow from RR2,DD2 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front


#--------------- small blowup box at d2

LL3=0.49
RR3=0.51
DD3=0
UU3=0.02

set arrow from LL3,DD3 to LL3,UU3 @BoxStyle
set arrow from LL3,UU3 to RR3,UU3 @BoxStyle
set arrow from RR3,UU3 to RR3,DD3 @BoxStyle
set arrow from RR3,DD3 to LL3,DD3 @BoxStyle

dX=0.057
dY=0.225
set arrow from LL3,UU3 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX= 0.185
dY=0.095
set arrow from RR3,DD3 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front

#--------------- points and labels at d0, ..., d3

X=0
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.1,0.6 

X=0.25
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d1" at X,Y offset 0.1,0.6 

X=0.5
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d2" at X,Y offset 0.1,0.6 

X=0.75
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d3" at X,Y offset 0.1,0.6 

X=1
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.1,0.6 


#--------------- main plot

set multiplot

T1=2700
T2=3000
p "basins/1.tna" u 1:($3<T1 && $5<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3<T1 && $5>T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  "basins/1.tna" u 1:($3>T1 && $3<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3>T2          ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  x>0 && x<1 ? f(x):1/0 w points ps 0.1 pt 7 lc rgb 'black',\
  'cyclic_cobwebB1.tna' w lines lw 2 lc rgb 'forest-green', \
  'cyclic_cobwebB2.tna' w lines lw 2 lc rgb 'dark-orange', \
  'cyclic_cobwebA1.tna' w lines lw 2 lc rgb 'blue', \
  'cyclic_cobwebA2.tna' w lines lw 2 lc rgb 'red', \
  x w lines lt 1 lw 1.5 lc rgb 'gray20'

unset arrow
unset label
unset xtics
unset ytics
unset xlabel
unset ylabel
unset border


#------------------------------------


#--------------- large blowup plot

set origin 0.15,0.59
set size 0.4,0.4
set xrange [LL:RR]
set yrange [DD:UU]


set arrow from LL,DD to LL,UU @BoxStyleW
set arrow from LL,UU to RR,UU @BoxStyleW
set arrow from RR,UU to RR,DD @BoxStyleW
set arrow from RR,DD to LL,DD @BoxStyleW

LW=2
set arrow from LL,DD to LL,UU @BoxStyle2
set arrow from LL,UU to RR,UU @BoxStyle2
set arrow from RR,UU to RR,DD @BoxStyle2
set arrow from RR,DD to LL,DD @BoxStyle2


p "basins/1.tna" u 1:($3<T1 && $5<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3<T1 && $5>T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  "basins/1.tna" u 1:($3>T1 && $3<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3>T2          ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  x w lines lt 1 lw 1.5 lc rgb 'gray20', \
  'cyclic_cobwebB1.tna' w l lw 2 lc rgb 'forest-green', \
  "" u 1:2:("s1") with labels point pt 7 ps 0.7 lc rgb 'forest-green' offset 0.5,-0.5,\
  "" u 1:2:("s1") with labels point pt 7 ps 0.5  lc rgb 'light-green' offset 0.5,-0.5,\
  'cyclic_cobwebB2.tna' w l lw 2 lc rgb 'dark-orange', \
  "" u 1:2:("s2") with labels point pt 7 ps 0.7 lc rgb 'dark-orange'  offset 0.5, -0.5,\
  "" u 1:2:("s2") with labels point pt 7 ps 0.5 lc rgb 'khaki1'       offset 0.5, -0.5,\
  'cyclic_cobwebA1.tna' w l lw 2 lc rgb 'blue', \
  "" u 1:2:("s3") with labels point pt 7 ps 0.7 lc rgb 'blue'	      offset 0.5,-0.5,\
  "" u 1:2:("s3") with labels point pt 7 ps 0.5 lc rgb 'light-cyan'   offset 0.5,-0.5,\
  'cyclic_cobwebA2.tna' w l lw 2 lc rgb 'red',\
  "" u 1:2:("s4") with labels point pt 7 ps 0.7 lc rgb 'red'          offset 0.75,0.25,\
  "" u 1:2:("s4") with labels point pt 7 ps 0.5 lc rgb 'pink'         offset 0.75,0.25


#------------------------------------
#--------------- small blowup plot at d1

set origin 0.367,0.15
set size 0.2,0.2
set xrange [LL2:RR2]
set yrange [DD2:UU2]


set arrow from LL2,DD2 to LL2,UU2 @BoxStyleW
set arrow from LL2,UU2 to RR2,UU2 @BoxStyleW
set arrow from RR2,UU2 to RR2,DD2 @BoxStyleW
set arrow from RR2,DD2 to LL2,DD2 @BoxStyleW

LW=2
set arrow from LL2,DD2 to LL2,UU2 @BoxStyle2
set arrow from LL2,UU2 to RR2,UU2 @BoxStyle2
set arrow from RR2,UU2 to RR2,DD2 @BoxStyle2
set arrow from RR2,DD2 to LL2,DD2 @BoxStyle2

X=0.25
set arrow from X,DD2 to X,UU2 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

Y=0.5*(DD2+UU2)
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d1" at X,Y offset 0.1,-0.3 


p "basins/1.tna" u 1:($3<T1 && $5<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3<T1 && $5>T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  "basins/1.tna" u 1:($3>T1 && $3<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3>T2          ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddffdd"


unset label
unset arrow

#------------------------------------
#--------------- small blowup plot at d2

set origin 0.505,0.15
set size 0.2,0.2
set xrange [LL3:RR3]
set yrange [DD3:UU3]


set arrow from LL3,DD3 to LL3,UU3 @BoxStyleW
set arrow from LL3,UU3 to RR3,UU3 @BoxStyleW
set arrow from RR3,UU3 to RR3,DD3 @BoxStyleW
set arrow from RR3,DD3 to LL3,DD3 @BoxStyleW

LW=2
set arrow from LL3,DD3 to LL3,UU3 @BoxStyle2
set arrow from LL3,UU3 to RR3,UU3 @BoxStyle2
set arrow from RR3,UU3 to RR3,DD3 @BoxStyle2
set arrow from RR3,DD3 to LL3,DD3 @BoxStyle2


X=0.5
set arrow from X,DD3 to X,UU3 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

Y=0.5*(DD3+UU3)
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d2" at X,Y offset 0.1,-0.3 


p "basins/1.tna" u 1:($3<T1 && $5<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3<T1 && $5>T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  "basins/1.tna" u 1:($3>T1 && $3<T2 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3>T2          ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddffdd"


unset multiplot
