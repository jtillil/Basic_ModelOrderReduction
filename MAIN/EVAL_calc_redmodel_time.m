% setup
I = model.I;
L = model.L;
I = config2I(I, repmat("dyn", [1 model.I.nstates]), L);
% I_red = config2I(I, redmodel.exhaustive_mor.configs(253, :), L);
I_red = config2I(I, redmodel.redobj.redconfig, L);

t = [0 6000];
X0 = model.X0;
par = model.par;
param = model.param;
multiple = model.multiple;
odefun = model.odefun;
jacfun = model.jacfun;

% calc time of full model
full_model_times = zeros([500 1]);
for i = 1:500
    fprintf([char(num2str(i)) ' '])
    tic
    [t_ref, X_ref, ~] = simModel(t, X0, par, I, param, multiple, odefun, jacfun);
    full_model_times(i) = toc;
end
fprintf('\n')
disp(mean(full_model_times(251:end)))
disp(std(full_model_times(251:end)))

% calc time of reduced model
red_model_times = zeros([500 1]);
for i = 1:500
    fprintf([char(num2str(i)) ' '])
    tic
    [t_red, X_red, ~] = simModel(t, X0, par, I_red, param, multiple, odefun, jacfun);
    red_model_times(i) = toc;
end
fprintf('\n')
disp(mean(red_model_times(251:end)))
disp(std(red_model_times(251:end)))

% check error
errfun = @(t_ref,X_ref,X_red) sqrt( trapz(t_ref,(X_ref-X_red).^2,1) ) ./ sqrt( trapz(t_ref,X_ref.^2,1) );
[t_ref, X_ref, ~] = simModel(model.t_ref, X0, par, I, param, multiple, odefun, jacfun);
[t_red, X_red, ~] = simModel(model.t_ref, X0, par, I_red, param, multiple, odefun, jacfun);
err = errfun(model.t_ref, model.X_ref, X_ref);
disp(err(model.I.output))
err = errfun(model.t_ref, model.X_ref, X_red);
disp(err(model.I.output))