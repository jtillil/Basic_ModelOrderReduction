function morexh(modelname, mode, eout, eint, pint, timeout, crit, errtype, firstrun, pnegrun, conlawrun, classifs, variability, LHS_EOG, variability_input, virtual_pop, X_ref_var, backwards, redmodel, log_required)

addpath(genpath('../Core'))
addpath(genpath('./results'))

if isempty(gcp('nocreate'))
    parpool();
end

mor_options.err_out = eout;
mor_options.err_int = eint;
mor_options.prct_int = pint;
mor_options.timeout = timeout; % in seconds, how long to allow a specific redmodel calculation to run. can also be inf for no bound
mor_options.criterion = crit; % one of 'out', 'linear', 'linear_time', 'max', 'remaining', 'quadratic'
mor_options.errtype = errtype; % one of 'MRSE', 'MALE'

mor_options.variability = variability;
mor_options.backwards = backwards;
mor_options.virtual_pop = virtual_pop;
mor_options.X_ref_var = X_ref_var;

mor_options.classifs_to_consider = classifs;
mor_options.conlawrun = conlawrun; % before firstrun, initially set conlaws
mor_options.firstrun = firstrun; % without qss
mor_options.pnegrun = pnegrun;
mor_options.log = log_required; % if to output logs

mor_options.saveroot = [modelname '_exh_t' num2str(mor_options.timeout) '_' errtype];
if mor_options.variability
    mor_options.saveroot = [mor_options.saveroot '_variability'];
    if variability_input
        mor_options.saveroot = [mor_options.saveroot 'input'];
    end
    if LHS_EOG
        mor_options.saveroot = [mor_options.saveroot 'lhseog'];
    end
    mor_options.saveroot = [mor_options.saveroot char(string(size(virtual_pop, 1) - 1))];
end
if mor_options.backwards
    mor_options.saveroot = [mor_options.saveroot '_backwards'];
end
if mor_options.conlawrun
    mor_options.saveroot = [mor_options.saveroot '_conrun'];
end
if mor_options.firstrun
    mor_options.saveroot = [mor_options.saveroot '_firstrun'];
end
mor_options.saveroot = [mor_options.saveroot '_' num2str(mor_options.err_out) '_' num2str(mor_options.err_int) '_' mor_options.criterion '_' char(strjoin(mor_options.classifs_to_consider, ''))];

% If wanted, first run without qss states for efficiency but only until
% half of the error bounds
% turned off by default
mor_options_firstrun = mor_options;
mor_options_firstrun.err_out = mor_options.err_out / 2;
mor_options_firstrun.err_int = mor_options.err_int / 2;
mor_options_firstrun.classifs_to_consider = setdiff(mor_options.classifs_to_consider, "pss", 'stable');

%% model reduction
switch mode
    case 'from_start'
        model = load([modelname '_minimal.mat']).model;
        [redmodel, log] = mor_exh_repeated(model, mor_options_firstrun, mor_options);
    case 'intermediate'
        % ...
    case 'finished'
        % ...
end

%% save reduced model
save(['results/' mor_options.saveroot '.mat'], 'redmodel', 'log', '-v7.3');

end