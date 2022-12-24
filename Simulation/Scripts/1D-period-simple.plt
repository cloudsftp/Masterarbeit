reset

set terminal png
set output 'result-simple.png'

load sprintf('%s/1D-period-core.plt', script_dir)
