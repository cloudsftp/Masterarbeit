set size square

load 'model.plt'

load 'dimens.plt'
set xrange [L:R]
set yrange [D:U]

plot 'cyclic_cobweb.tna' w lines lw 1 lc rgb 'blue' notitle, \
    f(x) w points ps 0.3 pt 7 lc rgb 'red' notitle, \
    x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
