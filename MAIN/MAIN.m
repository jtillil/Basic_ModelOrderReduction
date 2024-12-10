%% setup
clear; clc; close all;

addpath(genpath('../Core'))
addpath(genpath('../MAIN'))

%% standard parameters
eout = 0.1;             % 10% relative error bound on output
eint = 0.5;             % 50% relative error bound on other remaining states
pint = 100;             % percentile to calculate relative error on other remaining states (100 = max error)
timeout = 120;          % after 2 mins abort calculation of tentative reduced models
crit = 'linear';        % objective function (sum of error-bound-scaled errors on output and other remaining states)
errtype = 'MRSE';       % error metric (relative L2 norms)

%% run settings
% ignore these
firstrun = false;
pnegrun = false;
conlawrun = false;
log_required = false;

%% model selection
% select model here

modelname = 'modelBC';
% modelname = 'modelEGFR';

%% compatibility
% ignore these
redmodel = 0;
variability = 0;
LHS_EOG = 0;
backwards = 0;
variability_input = 0;
virtual_pop = 0;
X_ref_var = 0;

%% mode
mode = 'from_start';

%%%% all possible reduction approaches
% "dyn" "cneg" "pneg" "irenv_geom" "irenv_arith" "average" "mode" "constant" "constregr" "ssenv" "env" "pss" 

%%%% recommended reduction approaches (dyn should always be included)
% "dyn" "cneg" "pneg" "env" "irenv_geom" "pss" 

%% run
classifs = ["dyn" "cneg" "pneg" "env" "irenv_geom" "pss"];

morexh(modelname, mode, eout, eint, pint, timeout, crit, errtype, firstrun, pnegrun, conlawrun, classifs, variability, LHS_EOG, variability_input, virtual_pop, X_ref_var, backwards, redmodel, log_required)
