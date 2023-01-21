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

    real_t x_mod = currentState[0];
    if (x_mod >= n) {
        x_mod -= n;

        // disont in middle
        y += n;
    }
    
    if (x_mod < n / 2) {
        real_t x = x_mod - n / 4;
        y += aL * x * x + bL * x + cL;
    } else {
        real_t x = x_mod - 3 * n / 4;
        y += aR * x * x + bR * x + cR;
    }

    // normalize
    y = remainder(y, 2 * n);
    
    while (y < 0) {
        y += 2 * n;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
