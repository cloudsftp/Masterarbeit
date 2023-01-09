set size square

load 'dimens.plt'
set xrange [L:R]
set yrange [D:U]

file_exists(file) = int(system("[ -f '".file."' ] && echo '1' || echo '0'"))

if (file_exists(model_dir . '/model.plt')) {
    load 'model.plt'
    plot 'cyclic_cobweb.tna' w lines lw 1 lc rgb 'blue' notitle, \
        f(x) w points ps 0.3 pt 7 lc rgb 'red' notitle, \
        x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
} else { 
    if (file_exists('function.dat')) {
        plot 'cyclic_cobweb.tna' w lines lw 1 lc rgb 'blue' notitle, \
            'function.dat' w points ps 0.3 pt 7 lc rgb 'red' notitle, \
            x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
    }
}
