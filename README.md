# Test repo: greedy model order reduction

This is a model order reduction repository for testing.

## How to run

 - open Matlab
 - navigate to MAIN folder
 - start parallel pool with arbitrary number of workers
 - run("MAIN_BCSnake.m") to reduce blood coagulation model (8min at 20 parallel workers)
 - run("MAIN_EGFR.m") to reduce EGFR model (3.5h at 20 parallel workers)
 - reduced models are saved in MAIN/results

## How to read results

 - go to MAIN/results folder
 - load either or:
   - modelBCSnake-exh-t120-MRSE-0.1-0.5-linear-dyncnegpnegenvirenv-geom.mat
   - modelEGFR-exh-t120-MRSE-0.1-0.5-linear-dyncnegpnegenvirenv-geompss.mat
 - see variable "redmodel" for reduced model
 - see "redmodel.redobj" for general metrics of the reduced model
   - see "redmodel.redobj.ndyn" for number of ODEs remaining in the reduced model
   - see "redmodel.redobj.redconfig" for reduction approaches applied to individual states that define the reduced model
   - see "redmodel.redobj.error" for relative L2 approximation errors of all states in the reduced model
 - see "redmodel.exhaustive-mor" for logs of the reduction procedure
   - see "redmodel.exhaustive-mor.elapsedtime" for total time taken for model order reduction
   - see "redmodel.exhaustive-mor.finaliteration" for last iteration where error bounds were met
   - see "redmodel.exhaustive-mor.objvals" for log of objective funtion in every iteration:
     - column 1: number of remaining ODEs in the model
	 - column 2: relative L2 approximation error of model output (state number "model.I.output")
	 - column 3: maximum relative L2 approximation error of all remaining dynamic states
	 - column 4: time to simulate reduced model divided by time to simulate full model
 - use redmodel.t-ref, redmodel.X-ref to plot full model profiles
 - use redmodel.t-red, redmodel.X-red to plot reduced model profiles

## Included models

Core/modelfiles/modelBCSnake-minimal.mat
 - Wajima 2009: Blood coagulation network, snake venom scenario
 - 63 states, 174 parameters
 - input: Brown snake venom
 - output: Fibrinogen
 - time to reduce with 20 parallel workers: 8 min

Core/modelfiles/modelEGFR-minimal.mat
 - Hornberg 2005: Epidermial growth factor receptor signalling
 - 112 states, 296 parameters
 - input: Epidermial groth factor
 - output: Double-phosphorylized ERK
 - time to reduce with 20 parallel workers: 3.5 h

## Folders

### Core

#### Algorithms

Contains main scripts for the model reduction:
 - morexh-repeated.m starts the reduction
 - morexh-main-loop.m performs the main iterative greedy reduction procedure
 - morexh-finish-intermediate.m finishes the reduction, creates the reduced model and saves it

#### ConversionScripts

Contains compatibility scripts.

#### Core

Contains main helper scripts that run essential features (ode, jacobian, model simulation, objective function).

#### modelfiles

Contains model files which specify initial conditions, ode and jacobian.

### MAIN

The main folder. Contains scripts that set parameters for the model reduction and start the algorithm. Execute MAIN.m to start the reduction.