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

# P_3^20
X=-0.380
Y= 0.12662
set label "P.3.20" at X,Y front

# P_2^18
X=-0.384
Y= 0.12673
set label "P.2.18" at X,Y front

# P_2^20
X=-0.376
Y= 0.12673
set label "P.2.20" at X,Y front

# P_11^4
X=-0.3725
Y= 0.12662
set label "P.3.22" at X,Y front


# Q_3^20
X=-0.376
Y= 0.126665
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "Q.3.20" at X+dX,Y+dY offset -1.5,-1.3 front

# P_2^20 + P_4^22
X=-0.372
Y= 0.12668
h=1.0
dX=-(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.4.20+" at X+dX,Y+dY offset -3.2,0.7 front


# P_3^20 U P_3^18
X=-0.382
Y= 0.126658
h=1.0
dX=-(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.3.20uP.2.18" at X+dX,Y+dY offset -4.5,-1.5 front

# P_3^20 U P_10^4
X=-0.3805
Y= 0.126672
h=1.0
dX=(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.3.20uP.2.20" at X+dX,Y+dY offset 0.1,0.3 front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \

