#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define aL parameters[0]
#define aR parameters[1]
#define bL parameters[2]
#define bR parameters[3]
#define cL parameters[4]
#define cR parameters[5]

#define  n 0.5

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];
    if (x >= n) {
        x -= n;

        // disont in middle
        y += n;
    }
    
    if (x < n / 2) {
        y += aL * x * x + bL * x + cL;
    } else {
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

bool symbolic(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    string& RHS
) {
    real_t x = currentState[0];

    if (x < n) {
        if (x < 0.25) {
            RHS = "A";
        } else {
            RHS = "B";
        }
    } else {
        if (x < n + 0.25) {
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
