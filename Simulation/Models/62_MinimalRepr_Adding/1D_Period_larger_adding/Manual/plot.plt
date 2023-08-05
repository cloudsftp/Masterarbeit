reset

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output 'result_fm.eps'

set size square
set border lw 1

L = 0.082
R = 0.0835
D = 0
U = 128

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

LL = 0.0821
set arrow from LL,D to LL,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'LL' at LL,U offset 0.5, -1.5

RR = 0.0834
set arrow from RR,D to RR,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'RR' at RR,U offset -3.5, -1.5

LR = 0.08275
set arrow from LR,D to LR,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'LR' at LR,U offset 0.5, -1.5

LLR = 0.08248
set arrow from LLR,D to LLR,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'LLR' at LLR,U offset 0.5, -1.5

plot 'Data/period.tna' using 2:3 w p pt 5 ps 0.5 lc rgb 'blue' notitle 
