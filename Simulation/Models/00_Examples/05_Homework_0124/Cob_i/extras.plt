if (mu < 0) {
    set object 1 rect at mu/2, mu/2 size -mu, -mu \
        fs noborder solid 0.15 fc rgb 'red'

    set arrow from mu, mu to 0, mu lc rgb 'red'
    set arrow from mu, 0 to mu, mu lc rgb 'red'
    set arrow from 0, 0 to mu, 0 lc rgb 'red'
}
