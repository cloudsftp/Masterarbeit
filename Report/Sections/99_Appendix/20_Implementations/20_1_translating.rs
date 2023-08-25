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
