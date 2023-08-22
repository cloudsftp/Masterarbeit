# Symbolic Regions

A small program for detecting changes in the symbolic sequence in the output of AnT simulations.

## Installing Cargo

Recommended: Via [rustup](https://rustup.rs/)

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Once you run this installer, the command `cargo` should be available

## Executing

In the root directory of this project.

Execute

```
cargo run -- path/to/periodic_symbolic_sequence.tna > output_file
```

Or build

```
cargo build --release
```

and execute the binary directly

```
./target/release/symbolic-regions path/to/periodic_symbolic_sequence.tna > output_file
```
