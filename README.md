# Some Programs and scripts used in my thesis

This file contains a number of Matlab and Smoldyn scripts, as used in my PhD thesis. 
The full thesis is avaliable from the University of British Columbia, Canada.
It is named ``Deterministic and Stochastic Modeling of the Min
System for Cell Division'', and is being published in 2019.

In order to gain context for what these scripts are, and why they exist, please go and examine the actual thesis.

Here I give a BRIEF guide to what the scripts are in each of these files, and how to use them.

## Chapter 2
Chapter 2 of my thesis was associated with examining the occassional mismatch between particle based models of reaction-diffusion systems, and the associated PDE models.

In the corresponding folder of this repository, there are a number of smoldyn reaction files.
In order to use them, please install smoldyn on your system (http://www.smoldyn.org/download.html), and then open a terminal in the Chapter 2 file type:
```
smoldyn <SIMULATION_NAME_HERE>
```

## Chapter 3
Chapter 3 of my thesis involved exploring the bifurcation structure of a particular Min model due to William Carlquist. This was primarily done using the continuation package "Coco" for matlab.

In order to use the scripts in this file, you will need to have a working copy of matlab, and install the Coco (https://sourceforge.net/projects/cocotools/). Once this is done, you can then run `BuildBifurcationCarlquistModel.m` followed by `DrawBifurcationPlot.m`. The first function creates the data for a bifurcation diagram, the second draw things.

In order to alter the diagrams, you are best off opening `BuildBifurcationCarlquistModel.m` and changing either the grid of `D` and `E` where you start your bifurcation diagram, and also the `h` values.

The remaining files in the folder are helper scripts.

## Chapter 4
In chapter 4 of my thesis I examined how equations of the form $u_t=D \Delta u + u^2 +\xi$. 
The files `CartoonBurst.m`,`CartoonBurst_IC_noise.m` and `MoriBurst.m` are matlab scripts the give simple examples of burst bifurcations. You can run them by opening them in matlab and hitting 'run'. 

The script `BackForwardSolveAdaptive.m` will run the PDE's required to find the optimal spike for reaching height $u(0,T)=$``uTarget`` by time $T=$`tf`, assuming diffusion rate `D` in `m` dimensions.
If not previously defined, these values default to 10,10, 1 and 1, respectively. 

The script `IterateBFsolve.m` can be used to run `BackForwardSolveAdaptive.m` multipled times, for a collection of parameter values, and is primarily useful if (for example) you wish to leave your computer running overnight, testing the results for multiple set ups.


## License
MIT License

Copyright (c) [2018] [Alastair Jamieson-Lane]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.