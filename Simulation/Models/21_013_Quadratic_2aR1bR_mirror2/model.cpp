#include "AnT.hpp"

#include <cmath>
#include <iostream>

#define aL parameters[0]
#define aR parameters[1]
#define bL parameters[2]
#define bR parameters[3]
#define cL parameters[4]
#define cR parameters[5]
#define px parameters[6]
#define py parameters[7]

#define border 1.5

#define _aL (aL + 2 * 0.75 * px)
#define _aR (aR - 2 * 0.75 * px)
#define _bL (bL + 0.75 * px)
#define _bR (bR - 0.75 * px)
#define _cL (cL + 0.3395 * py)
#define _cR (cR - 0.3395 * py)

#define  n 3.0

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x_mod = currentState[0];
    if (x_mod >= n) {
        x_mod -= n;

        // discont in middle
        y += n;
    }
    
    if (x_mod < border) {
        real_t x = x_mod - n / 4;
        y += _aL * x * x + _bL * x + _cL;
    } else {
        real_t x = x_mod - 3 * n / 4;
        y += _aR * x * x + _bR * x + _cR;
    }

    // normalize
    y = remainder(y, 1 * n);
    
    while (y < 0) {
        y += 1 * n;
    }

    RHS[0] = y;
    return true;
}

extern "C" {
    void connectSystem() {
        MapProxy::systemFunction = f;
    }
}
