#!/usr/bin/env python

from math import cos, exp, floor, pi

mu = 0.5

R = 2.
L = 4.2e-3
Vref = 5.0
bt = 1

Lr1 = -R / L
T = 1. / 150

omega = 2 * pi / T
Lr = Lr1 / omega

def mod(a, b):
    return a - floor(a/b) * b

def F(xk, z, Kp, stepAlg, E0, hi, q, chi):
    if stepAlg == 1:
        return q*cos(xk+z)-Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z)
    elif stepAlg == 2:
        return q*cos(xk+z)+Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z)
    elif stepAlg == 3:
        return Kp+(q*cos(xk)-Kp*chi-Kp)*exp(Lr*z)-q*cos(xk+z)+Kp*chi*mu

def half(xk, Kp, stepAlg, E0, hi, q, chi):
    za = 0

    # Find 0.02 interval where 0point is

    fb = F(xk, za, Kp, stepAlg, E0, hi, q, chi)
    while True:
        fa = fb
        zb = za + 0.02
        fb = F(xk, zb, Kp, stepAlg, E0, hi, q, chi)

        if fa * fb <= 0:
            break

        za = zb

    # Find exactly, where 0point is

    while True:
        z = (za + zb) / 2
        fb = F(xk, z, Kp, stepAlg, E0, hi, q, chi)

        if fa * fb < 0:
            zb = z
        else:
            za = z
            fa = fb

        if za - zb <= 1e-15:
            break

    return (za + zb) / 2

def invert(xk, E0, hi, q, chi):
    if cos(xk) > 0:
        Kp = 1
    else:
        Kp = -1

    z_k = half(xk, Kp, 1, E0, hi, q, chi)
    z_0 = half(xk, Kp, 2, E0, hi, q, chi)

    if Kp == 1:
        if z_k < z_0:
            xk = mod(xk + z_k, 2 * pi)
        else:
            Kp = -1    
            xk = mod(xk + z_0, 2 * pi)

    else:
        if z_k < z_0:
            Kp = -1
            xk = mod(xk + z_k, 2 * pi)
        else:
            Kp = 1
            xk = mod(xk + z_0, 2 * pi)

    z_k = half(xk, Kp, 3, E0, hi, q, chi)
    xk = mod(xk + z_k, 2 * pi)

    return xk

def function(x, parameters):
    if "E0" not in parameters or "hi" not in parameters:
        raise Exception("Missing parameters")

    E0 = parameters["E0"]
    hi = parameters["hi"]

    q = R * Vref / bt / E0
    chi = R * hi / bt / E0

    return invert(x, E0, hi, q, chi)
