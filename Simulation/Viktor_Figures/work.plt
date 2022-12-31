reset

set macros
ArrowStyle="head size 0.015,15 lt 1 lw 2 lc rgb 'gray30' front"
DataStyleS  = "p ps 0.5 pt 7 lc rgb 'red'"
DataStyleU  = "d lc rgb 'blue'"
DataStyleCh = "d lc rgb 'forest-green'"

BoxStyleW = "nohead lt 1 lw 3 lc rgb 'white' front"  
BoxStyle = "nohead lt 1 lw 1 lc rgb 'blue' front"  


aL  = 1.5
mL  = 1.47

aM1 = 1.75
mM1 = -0.25

aM2 = 1.25
mM2 = 0.25

aM3 = -1.1
mM3 = 3.2

aR  = -1.2
mR  = -0.1


f(X) = (X < -1) ? aL  * X + mL  : \
       (X < 0)  ? aM1 * X + mM1 : \
       (X < 1)  ? aM2 * X + mM2 : \
       (X < 2)  ? aM3 * X + mM3 : aR * X + mR

unset key

set samples 1000
set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20

set output "bif_fm.eps"

L=-3
R=2.5
D=L
U=R

set size square 

set xrange [L:R]
set yrange [D:U]

set border lw 1

set xtics ("L" L, -1, "zx" 0, 1, 2) scale 0 nomirror offset -0.5, 0
set ytics ("D" D, "zy" 0, "U" U) scale 0.5 nomirror rotate by 90

set xlabel "x" offset 12, 1.8 
set ylabel "f" offset 4.2, 4.5 rotate by 90

set grid front

ArrowWidth=1


plot "cobweb.tna" u 2:3 w l lt 1 lw 1 lc rgb "orange",\
     f(x) w p ps 0.4 pt 7 lc rgb "red",\
     x w l lt 1 lw 1 lc rgb "gray20"


#     "cobweb.tna" u ($1 < 500 ? $2:1/0):3 w l lt 1 lw 1 lc rgb "orange",\
