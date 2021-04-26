% Checks that the given function matches the given hessian
% Uses x0 and x1 to compute the results, chosen from the domain
function hessianCheck( f_grad, f_hess, x0, x1 )
    for i=0:7 % Test for 1.5e1 to 1.5e-7
        r = 1.5*10^(-i);
        
        hess_value  = f_hess( x0 ) * x1;
        hess_approx = ( f_grad( x0 + r*x1 ) - f_grad( x0 ) ) / r;
        
        result_1 = norm( hess_value - hess_approx, 2 );
        fprintf("%e\t%e\n", r, result_1 );
    end
    fprintf("--------------------\n")
end