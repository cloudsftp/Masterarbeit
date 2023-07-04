package model_test

import (
	"testing"

	"github.com/cloudsftp/Masterarbeit/go-sim/model"
)

func TestSimple(t *testing.T) {
	m := model.NewMinRep(4, -.5, 0.168, 0.4, 0.525)
	c := model.CheckForCycle(m, 0.6)
	if len(c.Cycle) != 16 {
		t.Errorf("Expected cycle of period 16, got %v", c)
	}
}

func BenchmarkSimple(b *testing.B) {
	m := model.NewMinRep(1, 0, 0, 1, 0)
	for i := 0; i < b.N; i++ {
		model.CheckForCycle(m, 0)
	}
}
