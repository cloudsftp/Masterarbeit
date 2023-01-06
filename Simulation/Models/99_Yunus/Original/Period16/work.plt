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

L= 9
R= 20.8
D= 0.001
U= 0.32
set size ratio 1
set xrange [L:R]
set yrange [D:U]

set xtics 2
set ytics 0.05 rotate by 90
set tics out 
set xlabel "E0" offset 0,0
set ylabel "hi0" rotate by 90 offset 2,0

set label "1|7|1|7| (Type A)" at 13.8132,0.0549082 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "2|7|1|6| (Type B)" at 15.3045,0.0701392 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "2|6|2|6| (Type A)" at 15.674,0.0802198 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "3|6|2|5| (Type B)" at 16.0224,0.0903973 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "3|5|3|5| (Type A)" at 16.4287,0.104929 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "4|5|3|4| (Type B)" at 16.817,0.11934 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "4|4|4|4| (Type A)" at 17.2869,0.143029 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "5|4|4|3| (Type B)" at 17.9063,0.17 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "5|3|5|3| (Type A)" at 18.9,0.224643 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "6|3|5|2| (Type B)" at 19.7063,0.279482 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set label "6|2|6|2| (Type A)" at 20.1,0.31 point pt 7 ps 1.0 lc rgb "yellow" front font "Times-Roman,14"
set style rect back fs empty border lc rgb '#008800'
set object 1 rect from 16.6,0.11 to 18.9,0.19 lw 5


plot "period_selection16.tna" w p pt 5
