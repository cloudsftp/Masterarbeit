use std::fmt::{Display, Write};

const SYMBOLS_FULL: [char; 4] = ['A', 'B', 'C', 'D'];
const SYMBOLS_HALVED: [char; 2] = ['L', 'R'];

#[derive(Debug, Eq)]
struct FullCycle {
    sequence: Sequence,
}

impl PartialEq for FullCycle {
    fn eq(&self, other: &Self) -> bool {
        self.sequence.rotation_equals(&other.sequence)
    }
}

impl Display for FullCycle {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let symbols = SYMBOLS_FULL;
        for (i, p) in self.sequence.iter().enumerate() {
            let sym = symbols.get(p.0).ok_or(core::fmt::Error)?;
            f.write_fmt(format_args!("{} {}", sym, p.1))?;

            if i < self.sequence.len() - 1 {
                f.write_str("  ")?;
                if p.0 == symbols.len() - 1 {
                    f.write_char(' ')?;
                }
            }
        }
        Ok(())
    }
}

#[derive(Debug, Eq)]
struct HalvedCycle {
    sequence: Sequence,
}

impl PartialEq for HalvedCycle {
    fn eq(&self, other: &Self) -> bool {
        self.sequence.rotation_equals(&other.sequence)
    }
}

impl Display for HalvedCycle {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let symbols = SYMBOLS_HALVED;
        for (i, p) in self.sequence.iter().enumerate() {
            let sym = symbols.get(p.0).ok_or(core::fmt::Error)?;
            f.write_fmt(format_args!("{} {}", sym, p.1))?;

            if i < self.sequence.len() - 1 {
                f.write_str("  ")?;
                if p.0 == symbols.len() - 1 {
                    f.write_char(' ')?;
                }
            }
        }
        Ok(())
    }
}

type Sequence = Vec<(usize, usize)>;

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

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_display_full() {
        assert_eq!(
            "A 1  B 2  C 3  D 4",
            format!(
                "{}",
                FullCycle {
                    sequence: vec![(0, 1), (1, 2), (2, 3), (3, 4)]
                }
            )
        );
        assert_eq!(
            // TODO: auto D 0?
            "A 1  B 2  C 3  D 4   A 5  B 6  C 70  D 0",
            format!(
                "{}",
                FullCycle {
                    sequence: vec![
                        (0, 1),
                        (1, 2),
                        (2, 3),
                        (3, 4),
                        (0, 5),
                        (1, 6),
                        (2, 70),
                        (3, 0)
                    ]
                }
            )
        );
    }

    #[test]
    fn test_display_halved() {
        assert_eq!(
            "L 1  R 2",
            format!(
                "{}",
                HalvedCycle {
                    sequence: vec![(0, 1), (1, 2)]
                }
            )
        );
        assert_eq!(
            // TODO: auto D 0?
            "L 1  R 2   L 50  R 0",
            format!(
                "{}",
                HalvedCycle {
                    sequence: vec![(0, 1), (1, 2), (0, 50), (1, 0)]
                }
            )
        );
    }
}
