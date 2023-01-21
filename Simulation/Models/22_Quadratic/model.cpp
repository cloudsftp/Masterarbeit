#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define aL parameters[0]
#define aR parameters[1]
#define bL parameters[2]
#define bR parameters[3]
#define cL parameters[4]
#define cR parameters[5]

#define  n 3.0

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];
    
    if (x < n / 2) {
        x -= n / 4;
        y += aL * x * x + bL * x + cL;
    } else {
        x -= 3 * n / 4;
        y += aR * x * x + bR * x + cR;
    }

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
