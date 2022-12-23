reset

set samples 1000
set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set size square 

set output "result_fm.eps"

load sprintf('%s/load_extras.plt', script_dir)

plot 'period.tna' w dots palette
