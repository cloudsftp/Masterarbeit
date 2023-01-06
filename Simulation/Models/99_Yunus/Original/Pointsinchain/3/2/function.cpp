#include<iostream>
#include<cmath>
#include<cstdio>
#define real_t   double
#define Pi 3.14159265358979

/**/
#define E0 18.6379
#define hi 0.142051
#define mu 0.5
#define FILENAME "f.dat"
/**/

// ranges for the variable X
#define Xmin  0
#define Xmax  2*Pi
#define N   4000

#define R (2.0)
#define L (4.2E-3)
#define Vref 5.0
#define bt (1.0)

#define Lr1 (-R/L)
#define T (1.0/150)
#define q (R*Vref/bt/E0)
#define omega (2*Pi/T)
#define Lr (Lr1/omega)


#define chi (R*hi/bt/E0)

#define mod(a,b) (a-(floor(((int)a)/((int)b))*b))

// ---------------------------------------------------------------


real_t F(real_t xk, real_t z, real_t Kp, int StepAlg)
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

real_t half(real_t xk, real_t Kp, int StepAlg)
{
  real_t zk, za, zb, z, fk, fa, fb;
  zk = 0;
  fa = F(xk, zk, Kp, StepAlg);
  do
  {
    za = zk;
    fa = F(xk, za, Kp, StepAlg);
    zk += 0.02;
    fk = F(xk, zk, Kp, StepAlg);
  } while (fa*fk > 0);

  zb = zk;
  fa = F(xk, za, Kp, StepAlg);
  fb = F(xk, zb, Kp, StepAlg);

  do
  {
    z = 0.5*(za+zb);

    fk = F(xk, z, Kp, StepAlg);;
    if (fa*fk < 0) zb = z;
    else
    {
      za = z;
      fa = fk;
    }
  } while (fabs(za-zb)>1E-12);

  z = 0.5*(za+zb);

  return z;
}


bool pws_map ()
{
  real_t X;
  FILE *functionFile;

  real_t z0;
  real_t xk;
  real_t kf;
  real_t Kp;
  real_t et;
  real_t tk, tk1, tk2;
  real_t z, z_0, z_k;
  int StepAlg;
  real_t zk, za, zb;
  real_t fk, fa, fb;


  real_t dX = (Xmax-Xmin)/((real_t)N);

  functionFile = fopen (FILENAME,"w");

  for (int j=0; j<N ; ++j){

    X = Xmin + j * dX;
    fprintf (functionFile, "%14.12g ", X);

    xk=X;
 
  static long K = 0;
  static bool finish = false;

  if ((xk>=0) and (xk<Pi/2))
  {
    Kp = 1;
  }
  else
  {
    if ((xk>=3.0/2*Pi) and (xk<=2*Pi))
    {
      Kp = 1;
    }
    else
    {
      Kp = -1;
    }
  }
     
  if (Kp == 1)
  {
    for (StepAlg = 1; StepAlg <=2; ++StepAlg)
    {
      z = half(xk, Kp, StepAlg);
      if (StepAlg == 1) z_k = z;
      else z_0 = z;
    }
    if (z_k<z_0)
    {
      xk = mod(xk+z_k, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg);
      xk = mod(xk+z_k, 2*Pi);
    }
    else
    {
      Kp = -1;
      xk = mod(xk+z_0, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg);
      xk = mod(xk+z_k, 2*Pi);
    }
  }
  else
  {
    for (StepAlg = 1; StepAlg <=2; ++StepAlg)
    {
      z = half(xk, Kp, StepAlg);
      if (StepAlg == 1) z_k = z;
      else z_0 = z;
    }
    if (z_k < z_0)
    {
      Kp = -1;
      xk = mod(xk+z_k, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg);
      xk = mod(xk+z_k, 2*Pi);
    }
    else
    {
      Kp = +1;
      xk = mod(xk+z_0, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg);
      xk = mod(xk+z_k, 2*Pi);
    } // k
}
    fprintf (functionFile, "%14.12g\n", xk);
  }

  fclose (functionFile);
  return true;
}

int main (void)
{
  pws_map ();
  return 0;
}
