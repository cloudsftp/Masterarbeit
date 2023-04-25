#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define dl parameters[0]
#define hl parameters[1]
#define dr parameters[2]
#define hr parameters[3]
#define px parameters[4]
#define py parameters[5]

#define A (hl)
#define B (dl)
#define C (py)

#define D (hr)
#define E (dr)
#define F (-px)

#define _aL (2. * B + 4. * C - 4. * A)
#define _aR (2. * E + 4. * F - 4. * D)
#define _bL (2. * (A - C))
#define _bR (2. * (D - F))
#define _cL ((6. * A - B + 2. * C) / 8.)
#define _cR ((6. * D - E + 2. * F) / 8.)

#define border 0.5

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x_mod = currentState[0];
    
    if (x_mod < border) {
        real_t x = x_mod - 0.25;
        y += _aL * x * x + _bL * x + _cL;
    } else {
        real_t x = x_mod - 0.75;
        y += _aR * x * x + _bR * x + _cR;
    }

    // normalize
    while (y > 1) {
        y -= 1;
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

    if (x < border) {
        RHS = "A";
    } else {
        RHS = "B";
    }

    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
        MapProxy::symbolicFunction = symbolic;
    }
}
