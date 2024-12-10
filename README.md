# Test repo: greedy model order reduction

This is a model order reduction repository for testing.

## How to run

 - open Matlab
 - navigate to MAIN folder
 - start parallel pool with arbitrary number of workers
 - run("MAIN.m")
 - reduced models are saved in MAIN/results

## Included models

Core/modelfiles/modelBCSnake-minimal.mat
 - Wajima 2009: Blood coagulation network, snake venom scenario
 - 63 states, 174 parameters
 - input: Brown snake venom
 - output: Fibrinogen
 - time to reduce with 20 parallel workers: 20 min

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