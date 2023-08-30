
reset
E0 = 16.8
hi = 0.447
mu = 0.5

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

set size square
set border lw 1

set output 'result_fm.eps'

L = 16.725
R = 16.735
D = 0.1821
U = 0.1828

ArrowStyle ="lw 1 lc rgb 'black' front"
ArrowStyleW="lw 4 lc rgb 'white' front"

set label "BCBBL" at 16.7305, 0.182599 front
set arrow from 16.7302, 0.182613 to 16.7287, 0.182668 @ArrowStyleW
set arrow from 16.7302, 0.182613 to 16.7287, 0.182668 @ArrowStyle
set arrow from 16.7302, 0.182592 to 16.7276, 0.182537 @ArrowStyleW
set arrow from 16.7302, 0.182592 to 16.7276, 0.182537 @ArrowStyle

set label "BCBBD" at 16.7305, 0.18254 front
set arrow from 16.7325, 0.182515 to 16.7332, 0.182282 @ArrowStyleW
set arrow from 16.7325, 0.182515 to 16.7332, 0.182282 @ArrowStyle

set label "BCBAU" at 16.7312, 0.182168 front
set arrow from 16.7318, 0.18221 to 16.7312, 0.182393 @ArrowStyleW
set arrow from 16.7318, 0.18221 to 16.7312, 0.182393 @ArrowStyle

set label "BCBAR" at 16.7254, 0.182458 front
set arrow from 16.7262, 0.182433 to 16.7290, 0.182186 @ArrowStyleW
set arrow from 16.7262, 0.182433 to 16.7290, 0.182186 @ArrowStyle
set arrow from 16.7275, 0.182461 to 16.7314, 0.182457 @ArrowStyleW
set arrow from 16.7275, 0.182461 to 16.7314, 0.182457 @ArrowStyle

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

load 'extras.plt'

plot 'Data/0/regions_period.tna' w dots lc rgb 'orange' notitle, \
    'Data/1/regions_period.tna' w dots lc rgb 'purple' notitle, \
    'Data/2/regions_period.tna' u 2:1 w dots lc rgb 'blue' notitle, \
    'Data/3/regions_period.tna' u 2:1 w dots lc rgb 'red' notitle
