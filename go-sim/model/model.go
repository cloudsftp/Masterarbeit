package model

import (
	"bytes"
	"fmt"
	"math/big"
)

const (
	BUFFER_SIZE = 1 << 6
	PREC        = 1 << 9
	NUM_ITER    = 1 << 12
)

var epsilon = big.NewFloat(1e-12)

type Model interface {
	Step(in *big.Float) *big.Float
}

type CycleResult struct {
	StartValue float64
	Cycle      []*big.Float
}

func CheckForCycle(m Model, start float64) CycleResult {
	// Run initial iterations
	x := big.NewFloat(start).SetPrec(PREC)
	for i := 0; i < NUM_ITER; i++ {
		x = m.Step(x)
	}

	// Fill buffer with additional iterations
	var buf [BUFFER_SIZE]*big.Float
	for i := range buf {
		x = m.Step(x)
		buf[i] = x
	}

	// Detect cycles
	cycleLen := 0
	for i := 1; i < len(buf); i++ {
		t := zero()
		t.Sub(buf[0], buf[i])
		t.Abs(t)
		if t.Cmp(epsilon) < 0 {
			cycleLen = i
			break
		}
	}
	cycle := make([]*big.Float, cycleLen)
	for i := 0; i < cycleLen; i++ {
		cycle[i] = buf[i]
	}
	return CycleResult{start, cycle}
}

// Util

func zero() *big.Float {
	return big.NewFloat(0).SetPrec(PREC)
}

func (c CycleResult) String() string {
	var buf bytes.Buffer
	fmt.Fprintf(&buf, "starting value: %f, cycle: ", c.StartValue)
	for i, n := range c.Cycle {
		if i > 0 {
			buf.WriteString(", ")
		}
		val, _ := n.Float64()
		fmt.Fprintf(&buf, "%f", val)
	}
	fmt.Fprintf(&buf, ", period: %d", len(c.Cycle))
	return buf.String()
}
