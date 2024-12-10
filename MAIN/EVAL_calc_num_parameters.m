%% setup

model.multiple.multiple = false;

par = model.par;
num_par = 0;

% conf_idx = find(redmodel.exhaustive_mor.objvals(:, 1) == redmodel.redobj.ndyn, 1, 'last');
conf_idx = find(redmodel.exhaustive_mor.objvals(:, 1) == 25, 1, 'last');
config_red = redmodel.exhaustive_mor.configs(conf_idx, :);
I_red = config2I(model.I, config_red, model.L);

[tred, X_red, log] = simModel(model.t_ref, model.X0, model.par, I_red, model.param, model.multiple, model.odefun, model.jacfun);

ndyn = sum(config_red == "dyn");
npneg = sum(config_red == "pneg");
ncneg = sum(config_red == "cneg");
nenv = sum(config_red == "env");
ngeom = sum(config_red == "irenv_geom");
narith = sum(config_red == "irenv_arith");
npss = sum(config_red == "pss");

ntstart = 1;

%% calc

% TODO show which parameters are affected and how much
% TODO also count env and irenv for parameters and remove parameters that
%       are double due to env*par

for i = 1:length(par)
    disp(i)
    parval = par(i);
    if parval ~= 0
        % 1/1000x
        par_change = model.par;
        par_change(i) = (1e-3)*par_change(i);
        [tout, X_out, log] = simModel(model.t_ref, model.X0, par_change, I_red, model.param, model.multiple, model.odefun, model.jacfun);
        rel_err = abs(X_out(ntstart:end, :) - X_red(ntstart:end, :)) ./ X_red(ntstart:end, :);
        max_rel_err_div1e3 = max(rel_err(~isinf(rel_err)), [], 'all');
        % half
        par_change = model.par;
        par_change(i) = 0.5*par_change(i);
        [tout, X_out, log] = simModel(model.t_ref, model.X0, par_change, I_red, model.param, model.multiple, model.odefun, model.jacfun);
        rel_err = abs(X_out(ntstart:end, :) - X_red(ntstart:end, :)) ./ X_red(ntstart:end, :);
        max_rel_err_half = max(rel_err(~isinf(rel_err)), [], 'all');
        % double
        par_change = model.par;
        par_change(i) = 2*par_change(i);
        [tout, X_out, log] = simModel(model.t_ref, model.X0, par_change, I_red, model.param, model.multiple, model.odefun, model.jacfun);
        rel_err = abs(X_out(ntstart:end, :) - X_red(ntstart:end, :)) ./ X_red(ntstart:end, :);
        max_rel_err_double = max(rel_err(~isinf(rel_err)), [], 'all');
        % 1000x
        par_change = model.par;
        par_change(i) = (1e3)*par_change(i);
        [tout, X_out, log] = simModel(model.t_ref, model.X0, par_change, I_red, model.param, model.multiple, model.odefun, model.jacfun);
        rel_err = abs(X_out(ntstart:end, :) - X_red(ntstart:end, :)) ./ X_red(ntstart:end, :);
        max_rel_err_mul1e3 = max(rel_err(~isinf(rel_err)), [], 'all');
        if max([max_rel_err_half, max_rel_err_double, max_rel_err_div1e3, max_rel_err_mul1e3]) >= 1e-16
            num_par = num_par + 1;
        end
        disp(max_rel_err_half)
        disp(max_rel_err_double)
    end
end
