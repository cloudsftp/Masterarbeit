if (mu >= 0) {
    set object 1 circle at mu * 4, mu * 4 size 0.001 fillcolor rgb "red" fillstyle solid 1.0 front
}

if (mu < 0) {
    set object 1 circle at mu/3, mu/3 size 0.001 fillcolor rgb "blue" fillstyle solid 1.0 front
}
