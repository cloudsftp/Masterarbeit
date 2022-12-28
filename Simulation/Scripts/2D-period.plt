reset
set loadpath script_dir

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
   
set output "result_fm.eps"

set border lw 1

load 'dimens.plt'

set xrange [L to R]
set yrange [D to U]

set xtics ("L" L, "R" R) offset 0, -0.2
set ytics ("D" D, "U" U) rotate by 90

load 'load-extras.plt'

load '2D-period-core.plt'
