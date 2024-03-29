reset

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20

set size square
set border lw 1

set output "result_fm.eps"

L = -0.3745
R = -0.373
D = 0.12477
U = 0.12483

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

set label 'B' at -0.373697, 0.124797 point pointtype 7 lc rgb 'red' front

ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"

# P^20_3
X=-0.3743
Y= 0.12482
set label "P.20.3" at X,Y front

# P^22_4
X=-0.3733
Y= 0.12478
set label "P.22.4" at X,Y front

# P^22_4 + P^20_4
X=-0.3735
Y= 0.124825
set label "P.22.4+" at X,Y front

# P^20_3 + P^22_4
X=-0.37375
Y= 0.12478
h=1.0
dX=-(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.3+" at X+dX,Y+dY offset -10.0,0.5 front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \

