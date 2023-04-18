#include "AnT.hpp"

// External parameters
#define bL parameters[0]
#define px parameters[1] // Only the last two are varied
#define py parameters[2]

// Internal parameters for computing branches A and C
#define _bL (bL)
#define _cL (py)

// Internal parameters for fitting branches B and D
#define A (-px)
#define B (1.05)

// Internal parameters for computing branches B and D
#define _bR ((B - A) * 2.)
#define _cR ((A + B) / 2.)

#define border  0.5     // Discontinuity in the middle

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x_mod = currentState[0];

    if (x_mod < border) {   // "Left" branch
        real_t x = x_mod - 0.25;
        y += _bL * x + _cL;
    } else {                // "Right" branch
        real_t x = x_mod - 0.75;
        y += _bR * x + _cR;
    }

    // Normalize
    if (y >= 1) {
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
