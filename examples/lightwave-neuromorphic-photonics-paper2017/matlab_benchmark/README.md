# The Lorenz discrete-time simulator
This is a benchmark, so it's purpose is to plot the CTRNN and discrete time data in a way that can be compared, in addition to evaluating the discrete time performance.

## What is here:
1. `lorenz_sim` - efficient script that performs the simulation
2. `lorenz_sim_mex` - the optimized version of `lorenz_sim`
3. `lorenz_eval` - various evaluating/plotting, handling the parameters that will be sent to the simulator

## Setting up
This is happening mainly in MATLAB because it has powerful compiler libraries.

#### Generate some CTRNN data
Run the `Fourier Sinusoid Neuron_SciRep` notebook. This saves a .mat file with the nengo CTRNN data in `nengo_results.mat`.

#### Compile the optimized simulator (optional)
If you are just plotting paper figures, this is optional. The optimized version is only needed for performance analysis (plottype=2, below).

In the MATLAB command line, 
```
codegen lorenz_sim
```
You have to redo this if you make changes to the lorenz_sim file (e.g. to temporarily change it to deterministic).

#### Run the evaluator
The evaluator has three modes, determined by the `plottype` flag. If `plottype ==`

1. Prints pretty time traces and butterfly, with comparison to CTRNN
    - This is what makes the paper figures
2. Clocks performance of the simulator under test
3. Determines virtual time ratio (i.e. maximum `dt`) by looking at divergence probabilities of the simulator

