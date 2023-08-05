eps = 0.0000003

A = L + eps
AAB = L + 3 * eps
AB = 0.090325
B = R - eps

#set arrow from AAB,D to AAB,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
#set label 'AAB' at AAB,U offset 0.5, -1.5

#set arrow from AB,D to AB,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
#set label 'AB' at AB,U offset -3, -1.5

#set arrow from A,D to A,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
#set label 'A' at A,U offset 0.5, -1.5

#set arrow from B,D to B,U nohead lt 1 lw 2 dt 2 lc rgb "gray50" front
#set label 'B' at B,U offset -2, -1.5
