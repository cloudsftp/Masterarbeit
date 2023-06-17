use anyhow::{anyhow, Error};

use crate::cycles::{FullCycle, HalvedCycle, Sequence};

impl TryFrom<HalvedCycle> for Vec<FullCycle> {
    type Error = Error;
    fn try_from(value: HalvedCycle) -> Result<Self, Self::Error> {
        let og_len = value.sequence.len();
        let mut seq = value.sequence.clone();
        seq.extend_from_within(..);
        seq.extend_from_within(..seq.len() / 2);

        let sequences: Result<Vec<Sequence>, Error> = (0..og_len)
            .filter(|i| i % 2 == 0)
            .map(|i| translate_to_full_from_index(&seq, i, og_len))
            .collect();

        let cycles = sequences?.into_iter().map(|s| FullCycle { sequence: s });
        let mut unique_cycles = Vec::with_capacity(cycles.len());
        for cycle in cycles {
            let unique = &unique_cycles.iter().all(|u| u != &cycle);
            if *unique {
                unique_cycles.push(cycle);
            }
        }

        Ok(unique_cycles)
    }
}

fn translate_to_full_from_index(
    seq: &Sequence,
    start: usize,
    og_len: usize,
) -> Result<Sequence, Error> {
    let mut seq = seq[start..start + 2 * og_len].to_vec();

    for i in 0..seq.len() {
        let c = i % 4;
        if c < 2 && seq[i].0 != c {
            return Err(anyhow!("expected symbol {}, got {}", c, seq[i].0));
        }
        if c >= 2 {
            if seq[i].0 + 2 != c {
                return Err(anyhow!("expected symbol {}, got {}", c - 2, seq[i].0));
            }
            seq[i].0 = c;
        }
    }

    Ok(smallest_cycle(seq))
}

impl From<FullCycle> for HalvedCycle {
    fn from(value: FullCycle) -> Self {
        let new_seq: Sequence = value
            .sequence
            .into_iter()
            .map(|(sym, n)| {
                let new_sym = if sym < 2 { sym } else { sym - 2 };
                (new_sym, n)
            })
            .collect();
        let new_seq = smallest_cycle(new_seq);
        HalvedCycle { sequence: new_seq }
    }
}

fn smallest_cycle(seq: Sequence) -> Sequence {
    let length = (1..(seq.len() / 2) + 1)
        .filter(|i| {
            if seq.len() % i != 0 {
                return false;
            }

            let chunks: Vec<&[(usize, usize)]> = seq.chunks(*i).collect();
            (1..chunks.len()).all(|j| chunks[j] == chunks[0])
        })
        .next();

    match length {
        None => seq,
        Some(length) => seq[..length].to_vec(),
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn to_halved() {
        let full = FullCycle {
            sequence: vec![(0, 1), (1, 2), (2, 3), (3, 4)],
        };
        let halved: HalvedCycle = full.into();
        assert_eq!(halved.sequence, vec![(0, 1), (1, 2), (0, 3), (1, 4)]);

        let full = FullCycle {
            sequence: vec![(0, 1), (1, 2), (2, 1), (3, 2)],
        };
        let halved: HalvedCycle = full.into();
        assert_eq!(halved.sequence, vec![(0, 1), (1, 2)]);
    }

    #[test]
    fn to_full() {
        let halved = HalvedCycle {
            sequence: vec![(0, 1), (1, 2)],
        };
        let full: Vec<FullCycle> = halved.try_into().expect("failed");
        assert_eq!(full.len(), 1);
        assert_eq!(full[0].sequence, vec![(0, 1), (1, 2), (2, 1), (3, 2)]);

        let halved = HalvedCycle {
            sequence: vec![(0, 1), (1, 2), (0, 1), (1, 2)],
        };
        let full: Vec<FullCycle> = halved.try_into().expect("failed");
        assert_eq!(full.len(), 1);
        assert_eq!(full[0].sequence, vec![(0, 1), (1, 2), (2, 1), (3, 2)]);
    }

    #[test]
    fn to_full_multi() {
        let halved = HalvedCycle {
            sequence: vec![(0, 1), (1, 2), (0, 2), (1, 2)],
        };
        let full: Vec<FullCycle> = halved.try_into().expect("failed");
        assert_eq!(full.len(), 2);
        assert_eq!(full[0].sequence, vec![(0, 1), (1, 2), (2, 2), (3, 2)]);
        assert_eq!(full[1].sequence, vec![(0, 2), (1, 2), (2, 1), (3, 2)]);
    }
}
