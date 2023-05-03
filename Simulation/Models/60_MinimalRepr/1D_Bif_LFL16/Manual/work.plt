
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
L = -0.3815
R = -0.379


set xrange [L to R]
set yrange [D to U]

set xtics ("L"L, "R" R) nomirror
set ytics ('D' 0, 'U' 1) rotate by 90 nomirror

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

BCB1=-3.798361680840420e-01
BCB2=-3.806788394197099e-01


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
set label "d0" at X,Y offset 0.5,0.3 

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
set label "d3" at X,Y offset .5,0.6 

Y=1
X=R
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "d0" at X,Y offset 0.5,-0.3 




#--------------- main plot

set multiplot


set origin 0,0
set size 0.53,1
set xrange [L:R]
set yrange [D:U]
set arrow from BCB1,D to BCB1,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from BCB2,D to BCB2,1 nohead lt 1 lw 2 dt 2 lc rgb "gray50" front


Y=0.505
set arrow from R,Y rto 0.00032, 0.255 head @ArrowStyle
Y=0.495
set arrow from R,Y rto 0.00032,-0.255 head @ArrowStyle


Y=1.003
set arrow from R,Y rto 0.00032, 0.045 head @ArrowStyle
Y=0.995
set arrow from R,Y rto 0.00032,-0.140 head @ArrowStyle

Y=0.005
set arrow from R,Y rto 0.00032, 0.140 head @ArrowStyle
Y=-0.003
set arrow from R,Y rto 0.00032,-0.045 head @ArrowStyle


if(PLOT){
p 0.25 w filledcurves y2=0.0 lc rgb "#eeffee",\
  0.75 w filledcurves y2=0.5 lc rgb "#eeffee",\
  "Data/0/bif_cyclic.tna" u 1:($1>BCB2? $2:1/0) w d lc rgb "red",\
  "Data/1/bif_cyclic.tna" u 1:($1>BCB2? $2:1/0) w d lc rgb "forest-green",\
  "Data/2/bif_cyclic.tna" u 1:($1<BCB1? $2:1/0) w d lc rgb "blue"
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

set origin 0.49,0.75
set size 0.52,0.25

UU= 1.0002
DD= 0.999
set xrange [L:R]
set yrange [DD:UU]


X=-0.381
Y=0.9993
set label "O16Bb" at X,Y offset 0,0


if(PLOT){
p 1 w l lt 1 lw 1 dt 2 lc rgb "black",\
  "Data/2/bif_cyclic.tna" u 1:($1<BCB1? $2:1/0) w d lc rgb "blue",\
  "Data/1/bif_cyclic.tna" u 1:($1>BCB2? $2:1/0) w d lc rgb "forest-green"
}
else{
p 1/0
}

#--------------- middle plot
set origin 0.49,0.265
set size 0.52,0.5

UU=0.501
DD=0.499
set xrange [L:R]
set yrange [DD:UU]

X=-0.3803
Y=0.50058
set label "O14Ab" at X,Y offset 0,0.2

X=-0.381
Y=0.4993
set label "O16Ba" at X,Y offset 0,0.3


if(PLOT){
p U w filledcurves y2=0.5 lc rgb "#eeffee",\
  0.5 w l lt 1 lw 1 dt 2 lc rgb "black",\
  "Data/0/bif_cyclic.tna" u 1:($1>BCB2? $2:1/0) w d lc rgb "red",\
  "Data/1/bif_cyclic.tna" u 1:($1>BCB2? $2:1/0) w d lc rgb "forest-green",\
  "Data/2/bif_cyclic.tna" u 1:($1<BCB1? $2:1/0) w d lc rgb "blue"
}
else{
p 1/0
}

#--------------- lower plot

set origin 0.49,0.03
set size 0.52,0.25

UU= 0.001
DD=-0.0002
set xrange [L:R]
set yrange [DD:UU]
H=0.0063
set arrow from BCB1,DD to BCB1,H nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set arrow from BCB2,DD to BCB2,H nohead lt 1 lw 2 dt 2 lc rgb "gray50" front


X=-0.3803
Y=0.00058
set label "O14Aa" at X,Y offset 0,0

X=BCB1
Y=DD
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "BCB1" at X,Y offset 0.5,-1.2 

X=BCB2
Y=DD
set label "" at X,Y point pt 7 ps 1.1 lc rgb "black"  front
set label "" at X,Y point pt 7 ps 0.8 lc rgb "yellow" front
set label "BCB2a" at X,Y offset -7,-1.2 
set label "BCB2b" at X,Y offset -7, 1.0 


if(PLOT){
p U w filledcurves y2=0.0 lc rgb "#eeffee",\
  0 w l lt 1 lw 1 dt 2 lc rgb "black",\
  "Data/2/bif_cyclic.tna" u 1:($1<BCB1? $2:1/0) w d lc rgb "blue"
}
else{
p 1/0
}


unset multiplot
