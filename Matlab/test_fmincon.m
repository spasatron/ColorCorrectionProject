function xmin = test_fmincon(image,g)
%     A = -eye(3); b = zeros(3,1); % forces gammas to be positive
    lb = zeros(1,3); ub = [Inf,Inf,Inf];
    xmin = fmincon(@(g) my_diff(image,g),g,[],[],[],[],lb,ub,@(g) intensity_constraint(image,g));
end

function [c,ceq] = intensity_constraint(image,g)
    c = [];
    cr = 0.299;
    cg = 0.587;
    cb = 0.114;
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    ceq = cr.*sum(R.^g(1) - R,'all') + cg.*sum(G.^g(2) - G,'all') + cb.*sum(B.^g(3) - B,'all');
end