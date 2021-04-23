function x = min_diff_penalty_newton( image, x0, mu, tol, max_iter, tol_n, max_iter_n )
    
    I = my_intensity( image, [1, 1, 1]' );

    for k=1:max_iter
        
        % Do newton's method on the penalized problem
        xn = x0;
        for j=1:max_iter_n
            [~, grad, hess] = diff_quad_penalty_obj( image, I, xn, mu );
            
            xnp1 = ( xn - hess \ grad );

            if norm( xnp1 - xn, 2 ) / norm( xnp1 ) < tol_n
                break
            else
                xn = xnp1;
            end
        end
        x = xnp1;
        fprintf( "Iteration %d, mu = %d, iter = %d\nOptimal value:       %e\nChange in intensity: %e\n\n", ...
            k, mu, j, my_diff_smooth( image, x ), ( my_intensity( image, x ) - I ) );
        
        if norm( x0 - x, 2 ) / norm( x ) < tol
            break;
        else
            x0 = x;
        end
        
        mu = 2*mu;
    end
end