#include "AnT.hpp"

#define mod(a, b) ((a) - (int((a) / (b)) * (b)))

#define s parameters[0]
#define o parameters[1]

#define x currentState[0]
#define y RHS[0]

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t a = mod(x + (Pi / 2), Pi);
    y = s * a;
    
    // discont in both halfs
    if (a > Pi / 2) {
        y += o;
    }

    // discont in middle
    if (x > Pi) {
        y += Pi;
    }
    
    // normalize
    y = mod(y, 2 * Pi);

    return true;
}

extern "C"
{
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
