function g = min_diff_newtons( image, g0, tol, max_iter )
    for k=1:max_iter
        g = g0 - my_diff_hess( image, g0 ) \ my_diff_grad( image, g0 );
        if norm( g - g0, 2 ) / norm( g ) < tol
            break;
        else
            g0 = g;
        end
    end
end
