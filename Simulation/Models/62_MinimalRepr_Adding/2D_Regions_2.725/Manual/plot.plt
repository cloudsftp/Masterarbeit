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
D = 0.1266
U = 0.12675

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"

# P_10^3
X=-0.380
Y= 0.12662
set label "P.10.3" at X,Y front

# P_9^3
X=-0.384
Y= 0.12673
set label "P.9.3" at X,Y front

# P_10^4
X=-0.376
Y= 0.12673
set label "P.10.4" at X,Y front

# P_11^4
X=-0.3725
Y= 0.12662
set label "P.11.4" at X,Y front

# Q_10^3
X=-0.376
Y= 0.126665
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "Q.10.3" at X+dX,Y+dY offset -1.5,-1.3 front

# P_10^4 + P_11^4
X=-0.372
Y= 0.12668
h=1.0
dX=-(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.10.4+" at X+dX,Y+dY offset -3.2,0.7 front


# P_10^3 U P_10^4
X=-0.3805
Y= 0.126672
h=1.0
dX=(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.10.3uP.10.4" at X+dX,Y+dY offset 0.1,0.3 front

# P_10^3 U P_9^3
X=-0.382
Y= 0.126658
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.10.3uP.9.3" at X+dX,Y+dY offset -4.5,-1.5 front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \

