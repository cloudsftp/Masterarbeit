#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define a parameters[0]
#define b parameters[1]
#define c parameters[2]

#define  n 1.5

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;
    real_t x = currentState[0];
    
    x -= n / 2;
    y += a * x * x + b * x + c;

    // normalize
    y = remainder(y, n);
    
    while (y < 0) {
        y += n;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
