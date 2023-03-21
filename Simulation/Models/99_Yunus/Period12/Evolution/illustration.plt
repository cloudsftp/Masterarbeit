
reset
set loadpath '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/'

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "illustration_fm.eps"

set size square
set border lw 1

L = 0
R = 6.283
D = 0
U = 6.283

set xrange [L to R]
set yrange [D to U]

set xtics ('L' L, 'R' R)
set ytics ('D' D, 'U' U) rotate by 90

set xlabel 'x' offset 0, 1.3
set ylabel 'y' offset 4.2, 0 rotate by 90

plot  \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_A_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_B_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_C_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_Cp_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_Cpp_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_Cppp_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_D_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    '/home/fabi/Projects/Uni/Masterarbeit/Simulation/Models/99_Yunus/Period12/Cobweb_E_12/Autogen/Frame_0000/model.dat' w points ps 0.1 pt 7 lc rgb  'black' notitle, \
    
            