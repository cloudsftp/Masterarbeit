#include "AnT.hpp"

#include <cmath>

#define o (Pi / 2)

#define a parameters[0]
#define b parameters[1]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t x_og = currentState[0];
    real_t x_mod2pi = fmod(x_og + o, 2 * Pi);

    real_t y = 0;

    real_t x_modpi = x_mod2pi;
    if (x_modpi > Pi) {
        x_modpi -= Pi;

        y += Pi;
    }

    y += a * x_modpi;

    // discont in both halfs
    if (x_modpi > Pi / 2) {
        y += b;
    }

    // normalize
    y = fmod(y, 2 * Pi);

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
