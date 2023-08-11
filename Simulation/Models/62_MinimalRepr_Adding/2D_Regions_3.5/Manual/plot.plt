reset
set loadpath '..' '../..'

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20

set size square
set border lw 1

set output "result_fm.eps"

L = -0.385
R = -0.37
D = 0.1445
U = 0.1465

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"

# P^20_3
X=-0.383
Y= 0.1448
set label "P.20.3" at X,Y front

# P^18_3
X=-0.384
Y= 0.1462
set label "P.18.3" at X,Y front

# P^20_4
X=-0.375
Y= 0.1462
set label "P.20.4" at X,Y front

# P^22_4
X=-0.372
Y= 0.1446
set label "P.22.4" at X,Y front

# Q^20_3
X=-0.378
Y= 0.1454
set label "Q.20.3" at X,Y front

# P^20_3 u P^18_3
X=-0.384
Y= 0.14525
h=1.0
dX=(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.3uP.18.3" at X+dX,Y+dY offset -3.2,0.7 front

# P^18_3 u P^20_4
X=-0.3797
Y= 0.146
h=1.0
dX=(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.18.3uP.20.4" at X+dX,Y+dY offset 0.3,-0.7 front

# P^20_3 u Q^20_3
X=-0.377
Y= 0.14513
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.3uQ.20.3" at X+dX,Y+dY offset -6.2,-1.2 front

# P^22_4 u Q^20_3
X=-0.3732
Y= 0.1455
h=1.0
dX=(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.22.4uQ.20.3" at X+dX,Y+dY offset -3.5,-1.3 front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \
