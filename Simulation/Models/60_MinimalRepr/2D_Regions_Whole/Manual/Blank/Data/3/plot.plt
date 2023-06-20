
reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/21_002_Quadratic_aLbL_cR/2D_Period' '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/21_002_Quadratic_aLbL_cR'
aL = 1
aR = 1
bL = 0
bR = 0.15000000000000002
cL = 1
cR = 3
px = 0
py = 0

set terminal png
set output '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/21_002_Quadratic_aLbL_cR/2D_Period/Autogen/Frame_0003/result-simple.png'

set size square
set border lw 1

L = 0
R = 2
D = 0.1
U = 0.2

set xrange [L to R]
set yrange [D to U]

set xlabel 'px'
set ylabel 'py'

load '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/21_002_Quadratic_aLbL_cR/2D_Period/extras.plt'

unset colorbox
set palette rgbformulae 30,31,32
plot '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/21_002_Quadratic_aLbL_cR/2D_Period/Autogen/Frame_0003/period.tna' using 1:2:3 w dots notitle palette
