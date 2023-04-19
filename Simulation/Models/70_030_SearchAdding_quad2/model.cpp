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

#define A (2.1)
#define B (1.2)
#define C (px)

#define D (1.1)
#define E (1.2)
#define F (py)

#define _aL (E + F - D)
#define _aR (B + C - A)
#define _bL (D - F)
#define _bR (A - C)
#define _cL ((3. * D - E + F) / 4.)
#define _cR ((3. * A - B + C) / 4.)

#define n 2.0
#define border 1

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
