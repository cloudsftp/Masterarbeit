#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define aL parameters[0]
#define bL parameters[1]
#define aR parameters[2]
#define bR parameters[3]

#define n 0.5
#define border 0.25

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];
    if (x >= 0.5) {
        x -= 0.5;

        // disont in middle
        y += 0.5;
    }

    // offset A, C
    if (x <= 0.25) {
        y += aL * x + bL;
    } else {
        y += aL * x + bR;
    }

    // normalize
    y = remainder(y, 2 * Pi);
    
    while (y < 0) {
        y += 2 * Pi;
    }

    RHS[0] = y;
    return true;
}

bool symbolic(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    string& RHS
) {
    real_t x = currentState[0];

    if (x < n) {
        if (x < border) {
            RHS = "A";
        } else {
            RHS = "B";
        }
    } else {
        if (x < n + border) {
            RHS = "C";
        } else {
            RHS = "D";
        }
    }

    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
        MapProxy::symbolicFunction = symbolic;
    }
}
