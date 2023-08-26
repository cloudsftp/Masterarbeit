#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define a parameters[0]
#define b parameters[1]

#define n 0.5
#define border 0.25

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

    y += a * x;

    // offset A, C
    if (x <= border) {
        y += b;
    } else {
        y -= a * border;
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
