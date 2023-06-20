
reset

set macros
BoxStyle ="nohead front lt 1 lw 1 dt 1 lc rgb 'navy'"
BoxStyleW="nohead front lt 1 lw 10 dt 1 lc rgb 'white'"
BoxStyle2="nohead front lt 1 lw 2 dt 2 lc rgb 'navy'"

ArrowStyle ="size 0.05*(R-L),15 lt 1 lw 1 dt 1 lc rgb 'navy' front"

PLOT=1

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 0.5 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

unset key 
set samples 6000

eps=0.05
D = -eps
U =  1+eps

L = 0.16844
R = 0.16862


set xrange [L to R]
set yrange [D to U]

set xtics ("L"L, "R" R) nomirror
set ytics ('D' 0, 'U' 1) rotate by 90 nomirror

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

BCB1=0.168487
BCB2=0.168558


set arrow from BCB1,D to BCB1,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from BCB2,D to BCB2,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

#--------------- grid lines at d0, ... d3

set arrow from L,0 to R,0 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from L,1 to R,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front

X=0
set arrow from L,X to R,X nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.25
set arrow from L,X to R,X nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.5
set arrow from L,X to R,X nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=0.75
set arrow from L,X to R,X nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
X=1
set arrow from L,X to R,X nohead lt 1 lw 2 dt 2 lc rgb "gray50" front





#--------------- points and labels at d0, ..., d3

X=R
Y=0
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
#set label "d0" at X,Y offset -2.5,-0.2
set label "d0" at X,Y offset 0.4,-0.2 

X=R
Y=0.25
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d1" at X,Y offset 0.5,-0.2

Y=0.5
X=R
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d2" at X,Y offset 0.5,-0.2 

Y=0.75
X=R
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d3" at X,Y offset 0.5,-0.2 

Y=1
X=R
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.4,0.5 




#--------------- main plot

set multiplot


set origin 0,0
set size 0.53,1
set xrange [L:R]
set yrange [D:U]
set arrow from BCB1,D to BCB1,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from BCB2,D to BCB2,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front


Y=0.505
dX=0.0000245


Y=0.751
set arrow from R,Y rto dX, 0.3 head @ArrowStyle
Y=0.749
set arrow from R,Y rto dX,-0.21 head @ArrowStyle

Y=0.255
set arrow from R,Y rto dX, 0.21 head @ArrowStyle
Y=0.245
set arrow from R,Y rto dX,-0.3 head @ArrowStyle


if(PLOT){
p 0.25 w filledcurves y2=0.0 lc rgb "#eeffee",\
  0.75 w filledcurves y2=0.5 lc rgb "#eeffee",\
  "Data/0/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "red",\
  "Data/1/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "forest-green",\
  "Data/2/bif_cyclic.tna" u 1:($1>BCB1? $2:1/0) w d lc rgb "blue"
}
else{
p 1/0
}

unset xtics
unset ytics
unset xlabel
unset ylabel
unset arrow
unset label

#--------------- upper plot
set origin 0.49,0.503
set size 0.52,0.5

UU=0.751
DD=0.749
set xrange [L:R]
set yrange [DD:UU]

X=0.168495
Y=0.7496
set label "O16Bb" at X,Y offset 0,0

X=0.168495
Y=0.7503
set label "O16Ab" at X,Y offset 0,0


if(PLOT){
p 0.75 w filledcurves y2=D lc rgb "#eeffee",\
  0.75 w l lt 1 lw 1 dt 2 lc rgb "black",\
  "Data/0/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "red",\
  "Data/1/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "forest-green",\
  "Data/2/bif_cyclic.tna" u 1:($1>BCB1? $2:1/0) w d lc rgb "blue"
}
else{
p 1/0
}

#--------------- lower plot

set origin 0.49,0.03
set size 0.52,0.5

UU= 0.251
DD= 0.249
set xrange [L:R]
set yrange [DD:UU]
H=0.25326
set arrow from BCB1,DD to BCB1,H nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from BCB2,DD to BCB2,H nohead lt 1 lw 2 dt 2 lc rgb "gray50" front


X=BCB1
Y=DD
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "BCB1" at X,Y offset -5,-1.2 

X=BCB2
Y=DD
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "BCB2a" at X,Y offset 0.5,-1.2 
set label "BCB2b" at X,Y offset 0.5, 1.0 


X=0.168495
Y=0.2496
set label "O16Ba" at X,Y offset 0,0

X=0.168495
Y=0.2503
set label "O16Aa" at X,Y offset 0,0



if(PLOT){
p 0.25 w filledcurves y2=D lc rgb "#eeffee",\
  0.25 w l lt 1 lw 1 dt 2 lc rgb "black",\
  "Data/0/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "red",\
  "Data/1/bif_cyclic.tna" u 1:($1<BCB2? $2:1/0) w d lc rgb "forest-green",\
  "Data/2/bif_cyclic.tna" u 1:($1>BCB1? $2:1/0) w d lc rgb "blue"
}
else{
p 1/0
}


unset multiplot
