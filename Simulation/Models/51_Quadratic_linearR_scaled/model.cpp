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
#define A (px)
#define B (0.525)

// Internal parameters for computing branches B and D
#define _bR ((B - A) * 4.)
#define _cR ((A + B) / 2.)

#define n       0.5     // Discontinuity in the middle
#define border  0.25    // Discontinuity in the middle of the left half

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x_mod = currentState[0];

    // Enforce symmetry f(x + n) = f(x) + n
    if (x_mod >= n) {
        x_mod -= n;
        y += n;
    }

    if (x_mod < border) {   // "Left" branch (branches A and C)
        real_t x = x_mod - n / 4;
        y += _aL * x * x + _bL * x + _cL;
    } else {                // "Right" branch (branches B and D)
        real_t x = x_mod - 3 * n / 4;
        y += _bR * x + _cR;
    }

    // Normalize
    if (y > 2 * n) {
        y -= 2 * n;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}