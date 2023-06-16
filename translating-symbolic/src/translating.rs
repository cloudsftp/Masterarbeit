use crate::cycles::{FullCycle, HalvedCycle, Sequence};

impl From<HalvedCycle> for FullCycle {
    fn from(value: HalvedCycle) -> Self {
        todo!()
    }
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
}
