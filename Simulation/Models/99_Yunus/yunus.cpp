#include "AnT.hpp"

#define mod(a,b) ((a)-(floor((a)/(b))*(b)))

#define E0 parameters[0]
#define hi parameters[1]
#define mu parameters[2]

#define R (2.0)
#define L 4.2E-3
#define Vref 5.0
#define bt 1

#define Lr1 (-R/L)
#define T (1.0/150)
#define q (R*Vref/bt/E0)
#define omega (2*Pi/T)
#define Lr (Lr1/omega)


#define chi (R*hi/bt/E0)

real_t F(real_t xk, real_t z, real_t Kp, int StepAlg, const Array<real_t>& parameters)
{
  if (StepAlg == 1)
  {
    return q*cos(xk+z)-Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z);
  }
  else if (StepAlg == 2)
  {
    return q*cos(xk+z)+Kp*chi-(q*cos(xk)-Kp*mu*chi)*exp(Lr*z);
  }
  else
  {
    return Kp+(q*cos(xk)-Kp*chi-Kp)*exp(Lr*z)-q*cos(xk+z)+Kp*chi*mu;
  }
}

real_t half(real_t xk, real_t Kp, int StepAlg, const Array<real_t>& parameters)
{
  real_t zk, za, zb, z, fk, fa, fb;
  zk = 0;

  do {
    za = zk;
    fa = F(xk, za, Kp, StepAlg, parameters);
    zk += 0.02;
    fk = F(xk, zk, Kp, StepAlg, parameters);
  } while (fa*fk > 0);

  zb = zk;
  fa = F(xk, za, Kp, StepAlg, parameters);
  fb = F(xk, zb, Kp, StepAlg, parameters);

  do {
    z = 0.5*(za+zb);

    fk = F(xk, z, Kp, StepAlg, parameters);;

    if (fa*fk < 0) {
      zb = z;
    } else {
      za = z;
      fa = fk;
    }
  } while (fabs(za-zb)>1E-15);

  z = 0.5*(za+zb);

  return z;
}


bool invertor (const Array<real_t>& currentState,
  const Array<real_t>& parameters,
	Array<real_t>& RHS)
{
  real_t xk, Kp;
  real_t et;
  real_t tk, tk1, tk2;
  real_t z, z_0, z_k;
  int StepAlg;

  xk = currentState[0];

  if ((xk>=0) and (xk<Pi/2)) {
    Kp = 1;
  } else {
    if ((xk>=3.0/2*Pi) and (xk<=2*Pi)) {
      Kp = 1;
    } else {
      Kp = -1;
    }
  }

  for (StepAlg = 1; StepAlg <=2; ++StepAlg) {
    z = half(xk, Kp, StepAlg, parameters);
    if (StepAlg == 1) z_k = z;
    else z_0 = z;
  }
  
  z_k = half(xk, Kp, 1, parameters);
  z_0 = half(xk, Kp, 2, parameters);
  
  if (Kp == 1) {
    if (z_k<z_0) {
      xk = mod(xk+z_k, 2*Pi);
    } else {
      Kp = -1;
      xk = mod(xk+z_0, 2*Pi);
    }
  } else {
    if (z_k < z_0) {
      Kp = -1;
      xk = mod(xk+z_k, 2*Pi);
    } else {
      Kp = +1;
      xk = mod(xk+z_0, 2*Pi);
    }
  }

  z_k = half(xk, Kp, 3, parameters);
  xk = mod(xk+z_k, 2*Pi);

  RHS[0] = xk;
  return true;
}

extern "C"
{
  void connectSystem ()
  {
    MapProxy::systemFunction = invertor;
  }

}



