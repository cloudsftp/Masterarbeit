use clap::{Arg, ArgAction, Command};

fn main() {
    let matches = Command::new("Symbolic Sequence Regions")
        .arg(
            Arg::new("input")
                .required(true)
                .help("The input file containing symbolic sequences"),
        )
        .arg(
            Arg::new("vertical")
                .long("vertical")
                .action(ArgAction::SetTrue)
                .help("Set if the scan was vertical"),
        )
        .get_matches();

    let filename = matches.get_one::<String>("input").unwrap();

    symbolic_regions::process_file(filename);
}
