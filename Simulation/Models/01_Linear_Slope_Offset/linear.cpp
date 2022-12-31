#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define a parameters[0]
#define b parameters[1]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x_modpi = currentState[0];
    if (x_modpi >= Pi) {
        x_modpi -= Pi;

        // disont in middle
        y += Pi;
    }
    
    real_t x_modpihalves = x_modpi;
    if (x_modpihalves >= Pi / 2) {
        x_modpihalves -= Pi / 2;
    }

    y += a * x_modpihalves;

    // offset A, C
    if (x_modpi <= Pi / 2) {
        y += b;
    }

    // normalize
    y = remainder(y, 2 * Pi);
    
    while (y < 0) {
        y += 2 * Pi;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
