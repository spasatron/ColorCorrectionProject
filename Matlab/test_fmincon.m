function xmin = test_fmincon(image,g)
% This function tests the ability of fmincon to find the solution to the
% nonlinear scaling problem

% Input:  
% image   an N by M by 3 tensor containing the RGB channel values
% g       the gamma values for the RGB channels

% Ouput:
% xmin   the g that fmincon encounters
    lb = zeros(1,3); ub = [Inf,Inf,Inf]; % lower and upper bunds
    xmin = fmincon(@(g) my_diff(image,g),g,[],[],[],[],lb,ub,@(g) intensity_constraint(image,g));
end

% Enforces intensity to remain constant
function [c,ceq] = intensity_constraint(image,g)
    c = [];
    ceq = my_intensity(image,g) - my_intensity(image,[1;1;1]);
end