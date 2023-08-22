# Translating Symbolic

A small program automating the translation of the halved model into the full model.
Where the halved model is a circle map with two branches $L$ and $R$ and the full model is a circle map that is the halved model twice.
The full model has 4 branches $A, B, C,$ and $D$.

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
cargo run
```

The program will read input from `stdin`.
Type in a symbolic sequence in the following format:

`LR` or `L1R2` or `LRLRLRLR` or `L10R20`.
Whitespace is ignored.

On Enter, the symbolic sequence of the same cycle in the full model is displayed.
This may be two coexisting cycles.

`Ctrl-D` stops the program.
