#include "AnT.hpp"

#define alpha parameters[0]
#define beta  parameters[1]
#define X     currentState[0]
#define Y     currentState[1]

bool henon (const Array<real_t>&currentState,
	    const Array<real_t>& parameters,
	    Array<real_t>& rhs)
{
  
  rhs[0] = 1 - alpha * X * X + Y;
  rhs[1] = beta * X;

  return true;
}

extern "C" 
{

  void connectSystem ()
  {
    MapProxy::systemFunction = henon;
  }
}

