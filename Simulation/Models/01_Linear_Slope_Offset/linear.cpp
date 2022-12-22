#include "AnT.hpp"

#define mod(a, b) ((a) - (int((a) / (b)) * (b)))

#define o (Pi / 2)

#define a parameters[0]
#define b parameters[1]

#define x currentState[0]
#define y RHS[0]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t x_intern = mod(x + o, Pi);
    y = a * x_intern;
    
    // discont in both halfs
    if (x_intern > Pi / 2) {
        y += b;
    }

    // discont in middle
    if (mod(x, 2 * Pi) > Pi) {
        y += Pi;
    }
    
    // normalize
    y = mod(y, 2 * Pi);

    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
