% Checks that the given function matches the given gradient using 4 tests:
%   > First order forward FDM
%   > Second order Centered FDM
%   > Second order Taylor remainder convergence test
%   > Third order Taylor remainder convergence test
% Uses x0 and x1 to compute the results, chosen from the domain
function gradientCheck( f, f_grad, x0, x1 )
    N = size(x0, 1);

    fprintf("h\t\t\t\tFDM\t\t\t\tCDM\t\t\t\tTaylor Sanity\tTaylor Rmdr\t\t3rd Order\n")
    for i=0:7 % Test for 1.5e1 to 1.5e-7
        h = 1.5*10^(-i);
        
        grad_approx = zeros(N, 1);
        
        % Do test one, forward finite difference
        for j=1:N
            e = zeros(N, 1);
            e(j) = 1;
            grad_approx(j) = (f(x0 + h*e) - f(x0)) / h;
        end
        result_1 = norm( f_grad( x0 ) - grad_approx );
   
        % Do test two, centered finite difference
        for j=1:N
            e = zeros(N, 1);
            e(j) = 1;
            grad_approx(j) = (f(x0 + h*e) - f(x0 - h*e)) / 2 / h;
        end
        result_2 = norm( f_grad( x0 ) - grad_approx );
        
        % Do test 3, sanity check and 2nd order
        result_3_sanity = abs( f(x0) - f(x0 + h*x1) );
        
        result_3 = abs( f(x0) + dot( f_grad(x0), h*x1 ) - f(x0 + h*x1) );
        
        % Do test 4, 3rd order check
        result_4 = -2*(f(x0 + h*x1) - f(x0)) + dot( f_grad(x0) + f_grad(x0 + h*x1), h*x1 );
        
        % Print result in table
        fprintf("%e\t%e\t%e\t%e\t%e\t%e\n", h, result_1, result_2, result_3_sanity, result_3, result_4);
    end
    fprintf("-------------------------------\n")
end