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
D = 0.121
U = 0.1214

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

ArrowStyle ="backhead size graph 0.018,15 lt 1 lw 1 lc rgb 'black' front"
ArrowStyleW="backhead size graph 0.018,15 lt 1 lw 4 lc rgb 'white' front"

# P^20_3
X=-0.384
Y= 0.12104
set label "P.20.3" at X,Y front

# P^18_3
X=-0.384
Y= 0.12135
set label "P.18.3" at X,Y front

# P^20_4
X=-0.3723
Y= 0.12135
set label "P.20.4" at X,Y front

# P^22_4
X=-0.3723
Y= 0.12104
set label "P.22.4" at X,Y front

# P^20_3 u P^20_4
X=-0.3795
Y= 0.12119
set label "P.20.3uP.20.4" at X,Y  front


# P^20_3 + P^18_3
X=-0.384
Y= 0.12125
h=1.0
dX=(R-L)*0.05*h
dY=-(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.3+P.18.3" at X+dX,Y+dY offset -3.5,-1.2 front

# P^18_3 + P^20_4
X=-0.3809
Y= 0.12132
h=1.0
dX=(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.18.3+P.20.4" at X+dX,Y+dY offset 0,0.7 front

# P^20_3 + P^22_4
X=-0.3741
Y= 0.12104
h=1.0
dX=-(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.20.3+P.22.4" at X+dX,Y+dY offset -9.5,0.7 front

# P^22_4 + P^20_4
X=-0.372
Y= 0.12115
h=1.0
dX=-(R-L)*0.05*h
dY=(U-D)*0.05*h
set arrow from X,Y rto dX, dY @ArrowStyleW
set arrow from X,Y rto dX, dY @ArrowStyle
set label "P.22.4+P.20.4" at X+dX,Y+dY offset -3.5,0.7 front

plot \
    'Data/0/symbolic_regions.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/symbolic_regions.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/symbolic_regions.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/symbolic_regions.tna' u 2:1 w dots lc rgb 'red' notitle, \

