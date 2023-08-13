
reset

set macros
BoxStyle ="nohead front lt 1 lw 1 dt 1 lc rgb 'navy'"
BoxStyleW="nohead front lt 1 lw 10 dt 1 lc rgb 'white'"
BoxStyle2="nohead front lt 1 lw 2 dt 2 lc rgb 'navy'"

aL = 2.8
bL = -0.1
cL = 0
px = -0.37356
py = 0.12844

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

LL=0.499
RR=0.501
DD=LL
UU=RR

set arrow from LL,DD to LL,UU @BoxStyle
set arrow from LL,UU to RR,UU @BoxStyle
set arrow from RR,UU to RR,DD @BoxStyle
set arrow from RR,DD to LL,DD @BoxStyle

dX=-0.535
dY= 0.15
set arrow from LL,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front
dX=-0.14
dY= 0.55
set arrow from RR,UU rto dX,dY nohead lt 1 lw 1 dt 2 lc rgb "navy" front


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

T1=3200
p "basins/1.tna" u 1:($3<T1 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  x>0 && x<1 ? f(x):1/0 w points ps 0.1 pt 7 lc rgb 'black',\
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

X=0.5
set arrow from X,DD to X,UU nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

Y=DD+0.0003
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d2" at X,Y offset 0.1,-0.3 

p "basins/1.tna" u 1:($3<T1 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ffdddd",\
  "basins/1.tna" u 1:($3>T1 ? 1.0 : 1/0) w filledcurves y2=0 lc rgb "#ddddff",\
  x w lines lt 1 lw 1.5 lc rgb 'gray20', \
  'cyclic_cobwebA1.tna' w l lw 2 lc rgb 'blue', \
  "" u 1:2:("s3") with labels point pt 7 ps 0.7 lc rgb 'blue' offset 1.0, -0.5,\
  "" u 1:2:("s3") with labels point pt 7 ps 0.5  lc rgb 'light-cyan' offset 1.0, -0.5,\
  'cyclic_cobwebA2.tna' w l lw 2 lc rgb 'red', \
  "" u 1:2:("s4") with labels point pt 7 ps 0.7 lc rgb 'red'  offset 0.0, -1.0,\
  "" u 1:2:("s4") with labels point pt 7 ps 0.5 lc rgb 'pink' offset 0.0, -1.0


unset multiplot
