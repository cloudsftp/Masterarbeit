#include "AnT.hpp"

#define aL  parameters[0]
#define aR  parameters[1]
#define aM1 parameters[2]
#define aM2 parameters[3]
#define aM3 parameters[4]

#define mL  parameters[5]
#define mR  parameters[6]
#define mM1 parameters[7]
#define mM2 parameters[8]
#define mM3 parameters[9]

#define X     currentState[0]

bool pw_lin_map (const Array<real_t>& currentState,
		 const Array<real_t>& parameters,
		 Array<real_t>& RHS)
{
  
  
  if (X < -1)
    RHS[0] = aL * X + mL;
  else if (X < 0)
    RHS[0] = aM1 * X + mM1;
  else if (X < 1)
    RHS[0] = aM2 * X + mM2;
  else if (X < 2)
    RHS[0] = aM3 * X + mM3;
  else
    RHS[0] = aR * X + mR;
  
  return true;
}

/*
bool pw_lin_symbolic
(const Array<real_t>& currentState,
 const Array<real_t>& parameters,
 string& symbolicRHS)
{
  if (X < d1) 
    symbolicRHS = "L";
  else if (X < d2) 
    symbolicRHS = "M";
  else
    symbolicRHS = "R";
  return true;
}


*/

extern "C" 
{
  void connectSystem ()
  {
    MapProxy::systemFunction   = pw_lin_map;
    //    MapProxy::symbolicFunction = pw_lin_symbolic;
  }

}


