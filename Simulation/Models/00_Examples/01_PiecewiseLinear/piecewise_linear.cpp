#include "AnT.hpp"

#define a parameters[0]
#define mL parameters[1]
#define mR parameters[2]
#define mM parameters[3]

#define X     currentState[0]

bool pw_lin_map (const Array<real_t>& currentState,
		 const Array<real_t>& parameters,
		 Array<real_t>& RHS)
{
  
  
  if (X < -1)
    RHS[0] = a * X + mL;
  else if (X < 1)
    RHS[0] = a * X + mM;
  else
    RHS[0] = a * X + mR;
  
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


