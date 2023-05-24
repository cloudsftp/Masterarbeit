use std::println;

#[derive(Debug, Eq)]
pub struct SymbolicSequence<'a> {
    symbols: &'a Vec<char>,
    sequence: Vec<(usize, usize)>,
}

impl<'a> SymbolicSequence<'a> {
    pub fn empty(symbols: &'a Vec<char>) -> Self {
        SymbolicSequence {
            symbols,
            sequence: vec![],
        }
    }

    pub fn from(line: &str, symbols: &'a Vec<char>) -> Self {
        let mut sequence = vec![];
        let mut current = (0, 0);

        for c in line.chars() {
            let index = symbols.iter().position(|item| item == &c);
            let index = match index {
                None => continue,
                Some(index) => index,
            };

            if index != current.0 {
                if current.1 != 0 {
                    sequence.push(current);
                }
                current = (index, 1);
            } else {
                current.1 += 1;
            }
        }
        sequence.push(current);

        let mut seq = SymbolicSequence { symbols, sequence };
        seq.rotate();
        seq
    }

    fn rotate(&mut self) {
        let last = self.sequence.last().unwrap().clone();
        let first = self.sequence.first_mut().unwrap();
        if first.0 == last.0 {
            first.1 += last.1;
            self.sequence.pop();
        }

        let max = self
            .sequence
            .iter()
            .filter(|e| e.0 == 0)
            .max_by_key(|e| e.1)
            .unwrap()
            .1;
        let rot = self.sequence.iter().position(|e| e.1 == max).unwrap();

        self.sequence.rotate_left(rot);
    }
}

impl<'a> PartialEq for SymbolicSequence<'a> {
    fn eq(&self, other: &Self) -> bool {
        if self.symbols != other.symbols || self.sequence.len() != other.sequence.len() {
            return false;
        }

        (0..self.sequence.len()).any(|rot| {
            let mut s = self.sequence.clone();
            s.rotate_left(rot);
            s == other.sequence
        })
    }
}

#[cfg(test)]
mod test {
    use std::{assert_eq, vec};

    use super::*;

    #[test]
    fn test_create_symbolic() {
        let symbols = vec!['A', 'B'];
        let line = "-3.850000000000000e-01 1.444000000000000e-01  A A A A A A B B B (9)";
        let symseq = SymbolicSequence::from(line, &symbols);

        assert_eq!(symseq.sequence[0].0, 0);
        assert_eq!(symseq.sequence[0].1, 6);
        assert_eq!(symseq.sequence[1].0, 1);
        assert_eq!(symseq.sequence[1].1, 3);
    }

    #[test]
    fn test_create_symbolic_4() {
        let symbols = vec!['A', 'B', 'C', 'D'];
        let line = "-3.850000000000000e-01 1.444000000000000e-01  A A A A A A B B B C D (11)";
        let symseq = SymbolicSequence::from(line, &symbols);

        assert_eq!(symseq.sequence, vec![(0, 6), (1, 3), (2, 1), (3, 1)])
    }

    #[test]
    fn test_rotate() {
        let mut s = SymbolicSequence {
            symbols: &vec!['A', 'B'],
            sequence: vec![(0, 2), (1, 2), (0, 1)],
        };
        s.rotate();
        assert_eq!(s.sequence, vec![(0, 3), (1, 2)]);
    }

    #[test]
    fn test_rotate_weird() {
        let mut s = SymbolicSequence {
            symbols: &vec!['A', 'B'],
            sequence: vec![(0, 2), (1, 2), (0, 8), (1, 2), (0, 4)],
        };
        s.rotate();
        assert_eq!(s.sequence, vec![(0, 8), (1, 2), (0, 6), (1, 2)]);
    }

    #[test]
    fn test_eq() {
        let s1 = SymbolicSequence {
            symbols: &vec!['A', 'B'],
            sequence: vec![(0, 6), (1, 2), (0, 8), (1, 2)],
        };
        let s2 = SymbolicSequence {
            symbols: &vec!['A', 'B'],
            sequence: vec![(0, 8), (1, 2), (0, 6), (1, 2)],
        };
        assert_eq!(s1, s2);
    }

    #[test]
    fn test_bug_001() {
        let s = vec!['A', 'B', 'C', 'D'];
        let l1 = "-3.850000000000000e-01 1.444000000000000e-01  A A A A A A B B B (9)";
        let l2 = "-3.849324662331166e-01 1.444000000000000e-01  B A A A A A A B B (9)";
        assert_eq!(
            SymbolicSequence::from(l1, &s),
            SymbolicSequence::from(l2, &s)
        );
    }
}
