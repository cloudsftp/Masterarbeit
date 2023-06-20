pub mod symbolic;

use std::{fs, println, vec};

use crate::symbolic::SymbolicSequence;

pub fn process_file(filename: &str) {
    let contents = fs::read_to_string(filename).unwrap();
    let symbols = vec!['A', 'B', 'C', 'D'];

    let mut current = SymbolicSequence::empty(&symbols);
    for line in contents
        .lines()
        .filter(|l| !l.starts_with("#") && !l.is_empty())
    {
        let sequence = SymbolicSequence::from(line, &symbols);
        if sequence != current {
            current = sequence;
            println!("{line} ({current:?})");
        }
    }
}
