# Simulation

## Setup

You need to install [`conda`](https://docs.conda.io/en/latest/) and also [`AnT`](https://github.com/cloudsftp/AnT).

### AnT

To install `AnT`, download the source code and put it in the folder `AnT-src`.
Then you can use the script `build.sh` to build it.
The result will be the binaries and necessary libraries in the directory `AnT`.
Alternatively you can compile it manually, but the resulting binaries need to be at the same location.

## Usage
```
usage: simulAnT.py [-h] -m MODEL -d DIAGRAM [-n NUM_CORES]
                   [--simple-figure | --no-simple-figure]
                   [--skip-computation | --no-skip-computation]
                   [--dont-show | --no-dont-show]

options:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
  -d DIAGRAM, --diagram DIAGRAM
  -n NUM_CORES, --num-cores NUM_CORES
  --simple-figure, --no-simple-figure
  --skip-computation, --no-skip-computation
  --dont-show, --no-dont-show
```

So for example, to build Figure 6.1a, showing the 2D scan of the periods associated with parameter regions in the archetypal model, you would execute the following command.

```
python simulAnT.py -m MinimalRepr -d 2D_Period_Whole_Lotta_Points
```

2D scans take a lot of time to render with `fragmaster` etc. so you can use the option `--simple-figure` to speed up that process.

The script
- compiles the model implementation
- generates the `AnT` configuration file
- executes `AnT` with the compiled model and generated configuration file
- generates the Gnuplot script
- copies the `result_fm` file for `fragmaster`
- executes Gnuplot and `fragmaster`

The resulting picture will be in the subfolder if the diagram
So in this case in `Models/60_MinimalRepr/2D_Period_Whole_Lotta_Point`.
