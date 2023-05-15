
reset

set macros
BoxStyle ="nohead front lt 1 lw 1 dt 1 lc rgb 'navy'"
BoxStyleW="nohead front lt 1 lw 10 dt 1 lc rgb 'white'"
BoxStyle2="nohead front lt 1 lw 2 dt 2 lc rgb 'navy'"

set loadpath '../../'

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 0.5 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1
unset key 
set samples 6000

eps=0.15
L = -eps
R = 2*pi+eps
D = L
U = R


set xrange [L to R]
set yrange [D to U]

set xtics ('L' 0, 'R' 2*pi) nomirror
set ytics ('D' 0, 'U' 2*pi) rotate by 90 nomirror

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90



#--------------- grid lines at d0, ... d3

set arrow from L,0 to R,0 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from L,1 to R,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

X=0
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

X=0.27318
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=1.038084
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.27318+pi
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=1.038084+pi
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

X=2*pi
set arrow from X,D to X,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

set arrow from L,2*pi to R,2*pi nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

#--------------- large blowup box

LL=0.8
RR=0.9
DD=LL
UU=RR

set arrow from LL,DD to LL,UU @BoxStyle
set arrow from LL,UU to RR,UU @BoxStyle
set arrow from RR,UU to RR,DD @BoxStyle
set arrow from RR,DD to LL,DD @BoxStyle

dX=-0.84
dY=3.1
set arrow from LL,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX=1.4
dY=3.1
set arrow from RR,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front


#--------------- small blowup box at d1

LL2=0.27
RR2=0.276
DD2=0
UU2=0.02

set arrow from LL2,DD2 to LL2,UU2 @BoxStyle
set arrow from LL2,UU2 to RR2,UU2 @BoxStyle
set arrow from RR2,UU2 to RR2,DD2 @BoxStyle

dX=1.66
dY=1.59
set arrow from RR2,UU2 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX=2.55
dY=0.7
set arrow from RR2,DD2 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front


#--------------- small blowup box at d2

LL3=1.037490
RR3=1.0374912
DD3=0
UU3=0.02

set arrow from LL3,DD3 to LL3,UU3 @BoxStyle
set arrow from LL3,UU3 to RR3,UU3 @BoxStyle
set arrow from RR3,UU3 to RR3,DD3 @BoxStyle
set arrow from RR3,DD3 to LL3,DD3 @BoxStyle

dX=2.4
dY=1.59
set arrow from LL3,UU3 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX=3.25
dY=0.7
set arrow from RR3,DD3 rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front

#--------------- points and labels at d0, ..., d3

X=0.27318
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.1,0.6 

X=1.038084
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d1" at X,Y offset 0.1,0.6 

X=0.27318+pi
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d2" at X,Y offset 0.1,0.6 

X=1.038084+pi
Y=D
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d3" at X,Y offset 0.1,0.6 

#--------------- main plot

set multiplot

T1=3900
T2=1500
p "basins/1.tna" u 1:($3>T1          && $5>T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3<T1 && $4<T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1          && $5<T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  "basins/1.tna" u 1:($3<T1 && $4>T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  "function.dat" w points ps 0.1 pt 7 lc rgb 'black',\
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


p "basins/1.tna" u 1:($3>T1          && $5>T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3<T1 && $4<T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1          && $5<T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  "basins/1.tna" u 1:($3<T1 && $4>T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\
  x w lines lt 1 lw 1.5 lc rgb 'gray20', \
  'cyclic_cobwebA1.tna' w l lw 2 lc rgb 'blue', \
  "" u 1:2:("s1") with labels point pt 7 ps 0.7 lc rgb 'blue'	      offset -1.0, -1.2,\
  "" u 1:2:("s1") with labels point pt 7 ps 0.5 lc rgb 'light-cyan'   offset -1.0, -1.2,\
  'cyclic_cobwebA2.tna' w l lw 2 lc rgb 'red',\
  "" u 1:2:("s2") with labels point pt 7 ps 0.7 lc rgb 'red'          offset 1.0, 0.0,\
  "" u 1:2:("s2") with labels point pt 7 ps 0.5 lc rgb 'pink'         offset 1.0, 0.0,\
  'cyclic_cobwebB1.tna' w l lw 2 lc rgb 'forest-green', \
  "" u 1:2:("s3") with labels point pt 7 ps 0.7 lc rgb 'forest-green' offset 1.0, 0.0,\
  "" u 1:2:("s3") with labels point pt 7 ps 0.5  lc rgb 'light-green' offset 1.0, 0.0,\
  'cyclic_cobwebB2.tna' w l lw 2 lc rgb 'dark-orange', \
  "" u 1:2:("s4") with labels point pt 7 ps 0.7 lc rgb 'dark-orange'  offset 0.5, -0.5,\
  "" u 1:2:("s4") with labels point pt 7 ps 0.5 lc rgb 'khaki1'       offset 0.5, -0.5


#------------------------------------
#--------------- small blowup plot at d0

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

X=0.27318
set arrow from X,DD2 to X,UU2 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

Y=0.5*(DD2+UU2)
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.1,-0.3 


p "basins/1.tna" u 1:($3>T1          && $5>T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3<T1 && $4<T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1          && $5<T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  "basins/1.tna" u 1:($3<T1 && $4>T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\


unset label
unset arrow

#------------------------------------
#--------------- small blowup plot at d1

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


X=1.037490583019434
set arrow from X,DD3 to X,UU3 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

Y=0.5*(DD3+UU3)
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d1" at X,Y offset 0.1,-0.3 


p "basins/1.tna" u 1:($3>T1          && $5>T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  "basins/1.tna" u 1:($3<T1 && $4<T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1          && $5<T1 ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ddffdd",\
  "basins/1.tna" u 1:($3<T1 && $4>T2          ? 2*pi : 1/0) w filledcurves y2=0 lc rgb "#ffffdd",\


unset multiplot
