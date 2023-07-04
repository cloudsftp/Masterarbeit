package model

import (
	"math/big"
)

type MinRep struct {
	aL *big.Float
	bL *big.Float
	cL *big.Float
	bR *big.Float
	cR *big.Float
}

func NewMinRep(aL, bL, cL, A, B float64) MinRep {
	bR := 4 * (B - A)
	cR := (2 * A) - B
	return MinRep{
		big.NewFloat(aL),
		big.NewFloat(bL),
		big.NewFloat(cL),
		big.NewFloat(bR),
		big.NewFloat(cR),
	}
}

var (
	one       = big.NewFloat(1)
	half      = big.NewFloat(0.5)
	quarter   = big.NewFloat(0.25)
	zeroConst = big.NewFloat(0)
)

func (m MinRep) Step(xIn *big.Float) *big.Float {
	x := zero().Copy(xIn)
	y := zero()

	if x.Cmp(half) > 0 {
		x.Sub(x, half)
		y.Add(y, half)
	}

	tx := zero()
	if x.Cmp(quarter) > 0 {
		tx.Copy(x)
		tx.Mul(tx, m.bR)
		y.Add(y, tx)

		y.Add(y, m.cR)
	} else {
		tx.Copy(x)
		tx.Mul(tx, x)
		tx.Mul(tx, m.aL)
		y.Add(y, tx)

		tx.Copy(x)
		tx.Mul(tx, m.bL)
		y.Add(y, tx)

		y.Add(y, m.cL)
	}

	for y.Cmp(zeroConst) < 0 {
		y.Add(y, one)
	}
	for y.Cmp(one) >= 0 {
		y.Sub(y, one)
	}

	return y
}
