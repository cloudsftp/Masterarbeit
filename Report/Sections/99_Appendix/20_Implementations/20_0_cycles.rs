use std::fmt::{Display, Write};

pub const SYMBOLS_FULL: [char; 4] = ['A', 'B', 'C', 'D'];
pub const SYMBOLS_HALVED: [char; 2] = ['L', 'R'];

#[derive(Debug, Eq)]
pub struct FullCycle {
    pub sequence: Sequence,
}

impl FullCycle {
    fn period(&self) -> usize {
        self.sequence.iter().map(|p| p.1).sum()
    }

    fn rnum(&self, sym: usize) -> usize {
        self.sequence
            .iter()
            .filter(|p| p.0 == sym)
            .map(|p| p.1)
            .sum()
    }
}

impl PartialEq for FullCycle {
    fn eq(&self, other: &Self) -> bool {
        self.sequence.rotation_equals(&other.sequence)
    }
}

impl Display for FullCycle {
    /* ... */
}

#[derive(Debug, Eq)]
pub struct HalvedCycle {
    pub sequence: Sequence,
}

impl PartialEq for HalvedCycle {
    fn eq(&self, other: &Self) -> bool {
        self.sequence.rotation_equals(&other.sequence)
    }
}

impl Display for HalvedCycle {
    /* ... */
}

pub type Sequence = Vec<(usize, usize)>;

trait RotationEquivalence {
    fn rotation_equals(&self, other: &Self) -> bool;
}

impl RotationEquivalence for Sequence {
    fn rotation_equals(&self, other: &Self) -> bool {
        (0..self.len()).any(|rot| {
            let mut s = self.clone();
            s.rotate_left(rot);
            &s == other
        })
    }
}
