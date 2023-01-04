set terminal pngcairo size 500,500 enhanced font 'Verdana,10'
set output 'cobweb.png'

# Line width of the axes
set border linewidth 1.5
# Line styles
set style line 1 linecolor rgb '#bbbbbb' linetype 1 linewidth 0.5
set style line 2 linecolor rgb '#2596be' linetype 1 linewidth 1
set style line 3 linecolor rgb '#dd181f' linetype 1 linewidth 1

set xrange [0:1]
set yrange [0:1]

lin(x) = x
logistic(x) = 3.5 * x * (1-x)

plot    lin(x) notitle with lines linestyle 1, \
        logistic(x) notitle with lines linestyle 2, \
        'cyclic_cobweb.tna' notitle with lines linestyle 3
