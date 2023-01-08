#!/usr/bin/env python

from math import cos, exp, floor, pi
import argparse

def mod(a, b):
    return a - floor(a/b) * b

parser = argparse.ArgumentParser()
parser.add_argument('--E0', type=float, required=True)
parser.add_argument('--hi', type=float, required=True)
parser.add_argument('--rho', type=float, required=False)

args = parser.parse_args()

E0 = args.E0
hi = args.hi
mu = 0.5

R = 2.
L = 4.2e-3
Vref = 5.0
bt = 1

Lr1 = -R / L
T = 1. / 150
q = R * Vref / bt / E0
omega = 2 * pi / T
Lr = Lr1 / omega

chi = R * hi / bt / E0

def F(xk, z, Kp, stepAlg):
    if stepAlg == 1:
        return q*cos(xk+z)-Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z)
    elif stepAlg == 2:
        return q*cos(xk+z)+Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z)
    elif stepAlg == 3:
        return Kp+(q*cos(xk)-Kp*chi-Kp)*exp(Lr*z)-q*cos(xk+z)+Kp*chi*mu

def half(xk, Kp, stepAlg):
    za = 0

    # Find 0.02 interval where 0point is

    fb = F(xk, za, Kp, stepAlg)
    while True:
        fa = fb
        zb = za + 0.02
        fb = F(xk, zb, Kp, stepAlg)
        
        if fa * fb <= 0:
            break
            
        za = zb
    
    # Find exactly, where 0point is

    while True:
        z = (za + zb) / 2
        fb = F(xk, z, Kp, stepAlg)

        if fa * fb < 0:
            zb = z
        else:
            za = z
            fa = fb
        
        if za - zb <= 1e-15:
            break

    return (za + zb) / 2

def invert(xk):
    if cos(xk) > 0:
        Kp = 1
    else:
        Kp = -1

    z_k = half(xk, Kp, 1)
    z_0 = half(xk, Kp, 2)

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

    z_k = half(xk, Kp, 3)
    xk = mod(xk + z_k, 2 * pi)
    
    return xk

x = 0
while x <= 2 * pi:
    print(f"{x} {invert(x)}")
    x += 0.01
