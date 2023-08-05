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

#define A (px)
#define B (0.525)
#define C (1.2)

#define _aL (aL)
#define _aR (16. * A - 16. * B + 4. * C)
#define _bL (bL)
#define _bR (-16. * A + 16. * B - 3. * C)
#define _cL (cL + py)
#define _cR (4. * A - 3. * B + C / 2.)

#define n 0.5
#define border 0.25

bool f(
    const Array<real_t>& currentState,
    const Array<real_t>& parameters,
    Array<real_t>& RHS
) {
    real_t y = 0;

    real_t x = currentState[0];
    if (x >= n) {
        x -= n;

        // discont in middle
        y += n;
    }
    
    if (x < border) {
        y += _aL * x * x + _bL * x + _cL;
    } else {
        y += _aR * x * x + _bR * x + _cR;
    }

    // normalize
    y = remainder(y, 2 * n);
    
    while (y < 0) {
        y += 2 * n;
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
