#include "AnT.hpp"

// External parameters
#define aL parameters[0]
#define bL parameters[1]
#define cL parameters[2]
#define px parameters[3] // Only the last two are varied
#define py parameters[4]

// Internal parameters for computing branches A and C
#define _aL (aL)
#define _bL (bL)
#define _cL (cL + py)

// Internal parameters for fitting branches B and D
#define A (-px)
#define B (0.525)

// Internal parameters for computing branches B and D
#define _bR (4. * (B - A))
#define _cR ((2. * A) - B)

#define n       0.5     // Discontinuity in the middle
#define border  0.25    // Discontinuity in the middle of the left half

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];

    // Enforce symmetry f(x + n) = f(x) + n
    if (x >= n) {
        x -= n;
        y += n;
    }

    if (x < border) {   // "Left" branch (branches A and C)
        y += _aL * x * x + _bL * x + _cL;
    } else {            // "Right" branch (branches B and D)
        y += _bR * x + _cR;
    }

    // Normalize
    if (y >= 2 * n) {
        y -= 2 * n;
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
