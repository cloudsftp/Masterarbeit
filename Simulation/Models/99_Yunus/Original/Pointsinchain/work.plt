reset

set macros
ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"
DataStyleCyclic  = "d lc rgb 'gray80'"
DataStyleCyclic2 = "d lc rgb 'gray50'"
DataStyleAcyclic = "d lc rgb 'forest-green'"
BorderStyle = "l lt 2 lw 2 lc rgb 'black'"
LCStyle  = "l lt 1 lw 4 lc rgb 'black'"
LCStyleR = "l lt 1 lw 2 lc rgb 'red'"

BoxStyle = "nohead lt 4 lw 3 lc rgb 'black' front"  
BoxStyle = "nohead lt 2 lw 3 lc rgb 'blue' front"

unset key

set samples 1000
set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "TimesNewRoman" 18

set output "orbit_fm.eps"

L= 16
R= 22
D= 0.1
U= 0.4
set size ratio 1
set xrange [L:R]
set yrange [D:U]

set xtics 2
set ytics 0.1 rotate by 90
set tics out 
set xlabel "E0" offset 0,0
set ylabel "hi0" rotate by 90 offset 2,0

set label "1/1" at 16.3496,0.105731 point pt 7 ps 1.0 lc rgb "black" front 
set label "1/1,2" at 16.8143,0.119191 point pt 7 ps 1.0 lc rgb "black" front
set label "1/2" at 17.3049,0.14095 point pt 7 ps 1.0 lc rgb "yellow" front
set label "1/2,3" at 17.869,0.167607 point pt 7 ps 1.0 lc rgb "black" front
set label "1/3" at 18.7342,0.219643 point pt 7 ps 1.0 lc rgb "red" front
set label "1/3,4" at 19.82,0.29216 point pt 7 ps 1.0 lc rgb "black" front
set label "1/4" at 20.8745,0.367674 point pt 7 ps 1.0 lc rgb "green" front
set label "2/1" at 17,0.115086 point pt 7 ps 1.0 lc rgb "black" front
set label "2/1,2" at 17.3803,0.125987 point pt 7 ps 1.0 lc rgb "black" front
set label "2/2" at 18,0.160211 point pt 7 ps 1.0 lc rgb "yellow" front
set label "2/2,3" at 18.6478,0.18878 point pt 7 ps 1.0 lc rgb "black" front
set label "2/3" at 20,0.275774 point pt 7 ps 1.0 lc rgb "red" front

set cbrange [0:25]
plot "period.tna" with image


