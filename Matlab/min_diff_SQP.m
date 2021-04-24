function x = min_diff_SQP( image, x0, tol, max_iter )
    S = zeros( 4, 4 );
    F = zeros( 4, 1 );
    I = my_intensity( image, [1, 1, 1]' );
    
    for k=1:max_iter
        S(1:3, 1:3) = my_diff_hess( image, x0(1:3) ) + x0(4)*my_intensity_hess( image, x0(1:3) );
        S(1:3, 4) = my_intensity_grad( image, x0(1:3) );
        S(4, 1:3) = S(1:3, 4)';
        
        F(1:3) = my_diff_grad( image, x0(1:3) ) + x0(4)*my_intensity_grad( image, x0(1:3) );
        F(4) = my_intensity(image, x0(1:3)) - I;
        
        x = x0 - (S \ F);
        if norm(x(1:3)-x0(1:3), 2) + norm(x(4)-x0(4), 2) < tol
            break;
        else
            x0 = x;
        end
    end
end