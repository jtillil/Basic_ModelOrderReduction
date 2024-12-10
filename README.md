# Test repo: greedy model order reduction

This is the Johannes Tillil PhD model reduction repository.

## How to run

 - open Matlab
 - navigate to MAIN folder
 - start parallel pool with arbitrary number of workers
 - run("MAIN.m")

## Included models

Core/modelfiles/modelBCSnake-minimal.mat
 - Wajima 2009: Blood Coagulation, snake venom scenario
 - 63 states, 174 parameters
 - time to reduce with 20 parallel workers: 20 min

Core/modelfiles/modelEGFR-minimal.mat
 - Hornberg 2005: EGFR signalling
 - 112 states, 296 parameters
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