mod cycles;
mod parsing;
mod translating;

use std::{error::Error, io, io::prelude::*};

use crate::cycles::{FullCycle, HalvedCycle};

fn main() -> Result<(), Box<dyn Error>> {
    let mut lines = io::stdin().lock().lines();

    while let Some(line) = lines.next() {
        let line = line.expect("IO Error");

        let halved: HalvedCycle = line.into();
        let result: Vec<FullCycle> = halved.into();

        println!(
            "This cycle manifests as {} cycles in the full model:",
            result.len()
        );
        for cycle in result {
            println!("{}", cycle);
        }
        println!();
    }

    Ok(())
}
