use crate::cycles::{FullCycle, HalvedCycle, Sequence, SYMBOLS_FULL, SYMBOLS_HALVED};

impl From<String> for HalvedCycle {
    fn from(line: String) -> Self {
        let sequence = get_sequence(&line, &SYMBOLS_HALVED);
        Self { sequence }
    }
}

impl From<&str> for FullCycle {
    fn from(line: &str) -> Self {
        let sequence = get_sequence(line, &SYMBOLS_FULL);
        Self { sequence }
    }
}

fn get_sequence(line: &str, symbols: &[char]) -> Sequence {
    let mut sequence = Vec::new();

    let mut current_symbol = 0usize;
    let mut current_number = 0usize;
    let mut number_stack = Vec::new();

    for c in line.chars() {
        if c.is_digit(10) {
            number_stack.push(c);
        } else if number_stack.len() > 0 {
            current_number += parse_number_stack(&mut number_stack) - 1;
        }

        let index = symbols.iter().position(|item| item == &c);
        if let Some(index) = index {
            if index == current_symbol {
                current_number += 1;
            } else {
                sequence.push((current_symbol, current_number));

                current_symbol = index;
                current_number = 1;
            }
        }
    }
    if number_stack.len() > 0 {
        current_number += parse_number_stack(&mut number_stack) - 1;
    }
    sequence.push((current_symbol, current_number));

    sequence
}

fn parse_number_stack(number_stack: &mut Vec<char>) -> usize {
    let number_string = String::from_iter(number_stack.drain(..));
    let number: usize = number_string
        .parse()
        .expect("should be able to parse number is stack");
    number
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn parse_halved() {
        assert_eq!(
            HalvedCycle {
                sequence: vec![(0, 1), (1, 2)]
            },
            "L1R2".to_string().into()
        );
        assert_eq!(
            HalvedCycle {
                sequence: vec![(0, 1), (1, 2)]
            },
            "L  . 1    A     R  2        t".to_string().into()
        );
    }

    #[test]
    fn parse_halved_double_digits() {
        assert_eq!(
            HalvedCycle {
                sequence: vec![(0, 1), (1, 20)]
            },
            "L1R20".to_string().into()
        );
    }
}
