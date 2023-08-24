reset

set terminal postscript landscape enhanced color blacktext \
   dashed dashlength 1.0 linewidth 1.0 defaultplex \
   palfuncparam 2000,0.003 \
   butt "Helvetica" 20
set output "result_fm.eps"

unset border
unset xtics
unset ytics

set size square
set border lw 1

L = -0.25
R = 1.5
D = 0
U = 1.75

set xrange [L to R]
set yrange [D to U]

BorderStyle="lw 1 dt 2 lc '#808080' front nohead"
set arrow from 0, D to 0, U @BorderStyle
set arrow from 1, D to 1, U @BorderStyle

X = 0.55
Y = 1.5
Z = 0.5

a = Y - X - Z
b = Z
c = X

f(x) = a * x * x + b * x + c

s = 0.4
set label 'fX' at s, f(s) + 0.25

# blue fct
color = 'red'
CobStyle="lt 1 lw 2 dt 1 lc rgb color front nohead"

s = 0.25
set label 'Oa' at L+0.05, s+0.075
set arrow from L, s to s, s @CobStyle
while (s < 1) {
    y = f(s)
    set arrow from s, s to s, y @CobStyle
    set arrow from s, y to y, y @CobStyle
    s = y
}
set arrow from s, s to s, U @CobStyle

# red fct
color = 'blue'

s = 0.45
set label 'Ob' at L+0.05, s+0.075
set arrow from L, s to s, s @CobStyle
while (s < 1) {
    y = f(s)
    set arrow from s, s to s, y @CobStyle
    set arrow from s, y to y, y @CobStyle
    s = y
}
set arrow from s, s to s, U @CobStyle

plot    (x < 0 || x > 1) ? 1/0 : f(x) w points ps 0.3 pt 7 lc rgb 'black' notitle, \
        x w lines lt 1 lw 1.5 lc rgb 'gray20' notitle
