reset

unset colorbox

set samples 1000
set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set size square 

set output "result_fm.eps"

set border lw 1

load 'dimens.plt'

set xrange [L to R]
set yrange [D to U]

set xtics ("L" L, "R" R)
set ytics ("D" D, "U" U) rotate by 90 offset -0.5, 0

load sprintf('%s/load_extras.plt', script_dir)

plot 'period.tna' w dots notitle palette
