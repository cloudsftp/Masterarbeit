mod cycles;
mod parsing;
mod translating;

use std::{io, io::prelude::*};

use anyhow::Error;

use crate::cycles::{FullCycle, HalvedCycle};

fn main() -> Result<(), Error> {
    let mut lines = io::stdin().lock().lines();

    while let Some(line) = lines.next() {
        let line = line.expect("IO Error");

        let halved: HalvedCycle = line.into();
        println!("\nParsed: {} in the halved model", halved);

        let result: Result<Vec<FullCycle>, Error> = halved.try_into();
        match result {
            Ok(result) => {
                println!(
                    "This cycle manifests as {} cycles in the full model:",
                    result.len()
                );
                for (i, cycle) in result.iter().enumerate() {
                    println!(" {:2}: {}", i, cycle);
                }
            }
            Err(err) => println!("Couldn't translate the cycle: {}", err),
        }
        println!();
    }

    Ok(())
}
