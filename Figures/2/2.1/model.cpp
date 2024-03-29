#include "AnT.hpp"

#define mL parameters[0]
#define mR parameters[1]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];
    
    if (x < 0) {
        y = mL + 0.5 * x;
    } else {
        y = -mR + 0.5 * x;
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

    if (x < 0) {
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
