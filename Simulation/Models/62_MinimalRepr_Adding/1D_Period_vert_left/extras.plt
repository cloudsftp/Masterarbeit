eps = 0.0001

A = L + 2 * eps
AAB = L + 6 * eps
AB = (L + R) / 2
B = R - 4 * eps

set arrow from AAB,D to AAB,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'AAB' at AAB,U offset 0.5, -1.5

set arrow from AB,D to AB,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'AB' at AB,U offset 0.5, -1.5

set arrow from A,D to A,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'A' at A,U offset 0.5, -1.5

set arrow from B,D to B,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
set label 'B' at B,U offset 0.5, -1.5
