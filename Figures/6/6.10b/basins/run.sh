#!/bin/bash


sed -i 's/ A/A/g' periodic_symbolic_sequence.tna
sed -i 's/ B/B/g' periodic_symbolic_sequence.tna
sed -i 's/ C/C/g' periodic_symbolic_sequence.tna
sed -i 's/ D/D/g' periodic_symbolic_sequence.tna
./CompactifySequence periodic_symbolic_sequence.tna 1.tna
