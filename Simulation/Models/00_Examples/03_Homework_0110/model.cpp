#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define aL parameters[0]
#define aR parameters[1]
#define muL parameters[2]
#define muR parameters[3]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t x = currentState[0];
    real_t y = 0;
    
    if (x < 0) {
        y = aL * x + muL;
    } else {
        y = aR * x + muR;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
