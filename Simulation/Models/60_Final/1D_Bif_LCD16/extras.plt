d0 = 0
d1 = 0.25
d2 = 0.5
d3 = 0.75

p d1 with filledcurves y2=d0 lc rgb "gray90" notitle
p d3 with filledcurves y2=d2 lc rgb "gray90" notitle

set ytics add ("d1" d1)
set ytics add ("d2" d2)
set ytics add ("d3" d3)

set grid ytics

set object 1 rect from 0.1616, 0.247 to 0.16155, 0.253  fs empty border lc rgb 'black' front
