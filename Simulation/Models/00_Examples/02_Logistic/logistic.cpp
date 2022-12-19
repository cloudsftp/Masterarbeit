#include "AnT.hpp"

#define a parameters[0]

#define x currentState[0]
#define y RHS[0]

bool logistic(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    y = a * x * (1 - x);
    return true;
}

extern "C"
{
    void connectSystem() {
        MapProxy::systemFunction = logistic;
    }
}
