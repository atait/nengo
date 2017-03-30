# The Lorenz discrete-time simulator

## What is here:
1. `lorenz_sim` - minimal script that performs the simulation
2. `lorenz_sim_mex` - the optimized version of `lorenz_sim`
3. `lorenz_eval` - runs many times, doing various evaluating/plotting

## Setting up
This is happening mainly in MATLAB because it has excellent compiler libraries. It is also good for plotting.

#### Make a directory `ctrnn data` in the same directory as these files. 
Point the Fourier Sinusoid or whichever notebook to save `.mat` files there. Then, this code will use those to plot a nice side-by-side comparison.

The `ctrnn data/` directory is in the .gitignore

#### (Optional) Re-compile the simulator
by running, in the MATLAB command line, 
```
codegen lorenz_sim
```
This is as straightforward as it gets. You have to redo this if you make changes to the lorenz_sim file for whatever reason (e.g. to temporarily change it to deterministic)

The `codegen/` directory is in the .gitignore

#### Run the evaluator
The evaluator has three modes, determined by the `plottype` flag. If `plottype ==`

1. Prints pretty time traces and butterfly, with comparison to CTRNN
    - This is what makes the paper figures
2. Clocks performance of the simulator under test
3. Determines virtual time ratio (i.e. maximum `dt`) by looking at divergence probabilities of the simulator

