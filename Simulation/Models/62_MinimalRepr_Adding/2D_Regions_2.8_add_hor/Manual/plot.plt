reset
set loadpath '..' '../..'

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20

set size square
set border lw 1

set output "result_fm.eps"

L = -0.37
R = -0.36
D = 0.12851
U = 0.12854

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"

# P^20_4
X=-0.365
Y= 0.128535
set label "P.20.4" at X,Y front

# P^22_4
X=-0.365
Y= 0.128513
set label "P.22.4" at X,Y front

# P^22_4 + P^20_4
X=-0.368229
Y= 0.128524
h=1.0
dX=(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.22.4+" at X+dX,Y+dY offset -2.2, -1.2 front

# P^22_4 u P^20_4
X=-0.361447
Y= 0.128524
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.4u" at X+dX,Y+dY offset -7.0, -1.2 front

set label 'A' at -0.366362, 0.128526 point pointtype 7 lc rgb 'red' front 
set label 'B' at -0.363022, 0.128526 point pointtype 7 lc rgb 'red' front 
#set arrow from -0.366362, 0.1285277 to -0.366362, 0.128528 nohead front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \

