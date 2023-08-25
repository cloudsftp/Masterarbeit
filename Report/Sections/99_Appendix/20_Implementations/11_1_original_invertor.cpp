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
      z = half(xk, Kp, StepAlg, parameters);
      if (StepAlg == 1) z_k = z;
      else z_0 = z;
    }
    if (z_k<z_0)
    {
      xk = mod(xk+z_k, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg, parameters);
      xk = mod(xk+z_k, 2*Pi);
    }
    else
    {
      Kp = -1;
      xk = mod(xk+z_0, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg, parameters);
      xk = mod(xk+z_k, 2*Pi);
    }
  }
  else
  {
    for (StepAlg = 1; StepAlg <=2; ++StepAlg)
    {
      z = half(xk, Kp, StepAlg, parameters);
      if (StepAlg == 1) z_k = z;
      else z_0 = z;
    }
    if (z_k < z_0)
    {
      Kp = -1;
      xk = mod(xk+z_k, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg, parameters);
      xk = mod(xk+z_k, 2*Pi);
    }
    else
    {
      Kp = +1;
      xk = mod(xk+z_0, 2*Pi);
      StepAlg = 3;
      z_k = half(xk, Kp, StepAlg, parameters);
      xk = mod(xk+z_k, 2*Pi);
    }
  }

  RHS[0] = xk;
  return true;
}
