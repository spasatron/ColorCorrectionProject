function x = min_diff_penalty_newton( image, x0, mu, tol, max_iter )
    I = my_intensity( image, [1, 1, 1]' );
    
    % Do newton's method on the penalized problem
    for j=1:max_iter
        [diff, intensity, grad, hess] = diff_quad_penalty_obj( image, I, x0, mu );

        x = ( x0 - hess \ grad );

        if diff < tol && abs( intensity - I ) < tol
            break
        else
            x0 = x;
        end
    end
end