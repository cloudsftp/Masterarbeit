# Figures

The figures are organized in directories for each chapter that has figures.
Each of those directories has a directory for each figure.

## Executing

Depending on the type of figure and implementation the execution is slightly different.

### Simple `AnT` Simulation

If the figure depends on an `AnT` simulation with no post-processing, the execution is as follows.

- compile the `model.cpp` file
- run `AnT` with the compiled model for every `*.ant` configuration file
    - there might be configuration files in subdirectories, e.g. `Data`
- execute Gnuplot
    - If a `Makefile` is present, run `make`
    - If a `bash`-script is present, run that instead

### `AnT` Simulation with post-processing

In some cases, the `AnT` simulation results need some post-processing.
For example for Figures 7.3a, 7.3b, 7.3c, and 7.3d.

- compile the `model.cpp` file
- run `AnT` with the compiled model for every `*.ant` configuration file
    - there might be configuration files in subdirectories, e.g. `Data`
- execute `symbolic-regions`
    - in the directory `../symbolic-regions` execute `cargo run -- ../Figures/X/X.Ya/Data/Z/periodic_symbolic_sequence.tna > ../Figures/X/X.Ya/Data/Z/symbolic_regions.tna`
    - where `X.Ya` is the figure you want to create and `Z` is the ID of the data you want to process right now

### LaTeX or Gnuplot

In these cases, no manual execution is required.
Just run `make` if a `Makefile` is present or the present `bash`-script.

## List of Figures

### 2

- 2.1 [simple `AnT`](###simple-ant-simulation)
- 2.2a+b [LaTeX](###latex-or-gnuplot)
- 2.3 [simple `AnT`](###simple-ant-simulation)
- 2.4a-d [simple `AnT`](###simple-ant-simulation)
- 2.5a+b [simple `AnT`](###simple-ant-simulation)
- 2.6 [simple `AnT`](###simple-ant-simulation)

### 5

- 5.1 [Gnuplot](###latex-or-gnuplot)
- 5.2a [simple `AnT`](###simple-ant-simulation)
- 5.2b-d [Gnuplot](###latex-or-gnuplot)
- 5.3 [simple `AnT`](###simple-ant-simulation)
- 5.4a+b [Gnuplot](###latex-or-gnuplot)
- 5.5a+b [simple `AnT`](###simple-ant-simulation)
- 5.6a-c [simple `AnT`](###simple-ant-simulation)
- 5.7a+b [simple `AnT`](###simple-ant-simulation)
- 5.8a-c [simple `AnT`](###simple-ant-simulation)
- 5.9 [simple `AnT`](###simple-ant-simulation)
- 5.10a-c [simple `AnT`](###simple-ant-simulation)
- 5.11a+b [simple `AnT`](###simple-ant-simulation)
- 5.12a-c [simple `AnT`](###simple-ant-simulation)
- 5.13a+b [Gnuplot](###latex-or-gnuplot)
- 5.14a+b [simple `AnT`](###simple-ant-simulation)
- 5.15a-c [simple `AnT`](###simple-ant-simulation)
