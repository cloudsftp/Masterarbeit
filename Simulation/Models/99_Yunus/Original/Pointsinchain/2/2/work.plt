reset

set macros
ArrowStyle="head size 0.015,15 lt 1 lw 2 lc rgb 'gray30' front"
DataStyleS  = "p ps 0.5 pt 7 lc rgb 'red'"
DataStyleU  = "d lc rgb 'blue'"
DataStyleCh = "d lc rgb 'forest-green'"

BoxStyleW = "nohead lt 1 lw 3 lc rgb 'white' front"  
BoxStyle = "nohead lt 1 lw 1 lc rgb 'blue' front"  

 shift(x)=x>1.5*pi? x - 2*pi : x

unset key

set samples 1000
set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20

set output "bif_fm.eps"

L=-pi/2.
R=3./2.*pi
D=L
U=R

set size square 

set xrange [L:R]
set yrange [D:U]

set border lw 1

set xtics ("-{/Symbol P}/2" L, "0" 0, "3/2*{/Symbol P}" R) scale 0 nomirror offset -0.5, 0
set ytics ("" D, "0" 0, "3/2*{/Symbol P}" U) scale 0.5 nomirror rotate by 90

set xlabel "x" offset 8, 1.8 
set ylabel "f(x)" offset 4.2, 3.5 rotate by 90

set arrow from 0, D to 0, U lt 1 lw 2 dt 3 lc rgb "gray30" nohead
set arrow from L, 0 to R, 0 lt 1 lw 2 dt 3 lc rgb "gray30" nohead

Disc=0.28
A=Disc
set arrow from A,D to A,U lt 1 lw 1 dt 3 lc rgb "gray30" nohead front
set label "" at A,D point pt 7 ps 1.3 lc rgb "black" front
set label "" at A,D point pt 7 ps 1.0 lc rgb "yellow" front
set label "d0" at A,D offset 0, 0.8


Disc=1.15
A=Disc
set arrow from A,D to A,U lt 1 lw 1 dt 3 lc rgb "gray30" nohead front
set label "" at A,D point pt 7 ps 1.3 lc rgb "black" front
set label "" at A,D point pt 7 ps 1.0 lc rgb "yellow" front
set label "d1" at A,D offset 0, 0.8


Disc=3.43
A=Disc
set arrow from A,D to A,U lt 1 lw 1 dt 3 lc rgb "gray30" nohead front
set label "" at A,D point pt 7 ps 1.3 lc rgb "black" front
set label "" at A,D point pt 7 ps 1.0 lc rgb "yellow" front
set label "d2" at A,D offset 0, 0.8

Disc=4.29
A=Disc
set arrow from A,D to A,U lt 1 lw 1 dt 3 lc rgb "gray30" nohead front
set label "" at A,D point pt 7 ps 1.3 lc rgb "black" front
set label "" at A,D point pt 7 ps 1.0 lc rgb "yellow" front
set label "d3" at A,D offset 0, 0.8

plot "cobweb.tna" u (shift($2)):(shift($3)) w l lt 1 lw 1 lc rgb "forest-green",\
 "f.dat" u (shift($1)):(shift($2)) w p pt 7 ps 0.2 lc rgb "red",\
x w l lt 1 lw 1 lc rgb "gray20"

