if (mu < 0) {
    set object 1 rect at mu/2, mu/2 size -mu, -mu fs noborder solid 0.15 fc rgb 'red'
        
    set object 2 circle at mu/2, mu/2 size 0.001 fillcolor rgb "blue" fillstyle solid 1.0 front
    set object 3 circle at -mu, -mu size 0.001 fillcolor rgb "blue" fillstyle solid 1.0 front

    #set arrow from mu, mu to mu, 0 lc rgb 'red'
    #set arrow from mu, 0 to 0, 0 lc rgb 'red'
    #set arrow from 0, 0 to 0, mu lc rgb 'red'
}
