#include "AnT.hpp"

// External parameters
#define px parameters[0]
#define py parameters[1]

// Internal parameters for fitting branch L
#define A (py)
#define B (0.275)

// Internal parameters for computing branch L
#define _bL ((B - A) * 4.)
#define _cL ((A + B) / 2.)

// Internal parameters for fitting branch R
#define C (-px)
#define D (0.525)

// Internal parameters for computing branch R
#define _bR ((D - C) * 4.)
#define _cR ((C + D) / 2.)

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
        y += _bL * x + _cL;
    } else {                // "Right" branch (branches B and D)
        real_t x = x_mod - 3 * n / 4;
        y += _bR * x + _cR;
    }

    // Normalize
    if (y >= 1 * n) {
        y -= 1 * n;
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
            RHS = "L";
        } else {
            RHS = "R";
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
