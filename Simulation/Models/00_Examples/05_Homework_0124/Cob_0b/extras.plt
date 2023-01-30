if (mu < 0) {
    set object 1 rect at mu/2, 0 size -mu, -2 * mu fs noborder solid 0.15 fc rgb 'red'
    set object 2 rect at -mu/2, -mu/4 size -mu, -1.5 * mu fs noborder solid 0.15 fc rgb 'red'
    set object 3 polygon from 0, mu/2 to 0, mu to -mu, mu/2 to 0, mu/2 fs noborder solid 0.15 fc rgb 'red'

    set arrow from 0, mu to mu, mu lc rgb 'red'
    set arrow from mu, mu to mu, -mu lc rgb 'red'
    set arrow from mu, -mu to -mu, -mu lc rgb 'red'
}

if (mu >= 0) {
    set object 2 circle at 2 * mu, 2 * mu size 0.001 fillcolor rgb "blue" fillstyle solid 1.0 front
}
