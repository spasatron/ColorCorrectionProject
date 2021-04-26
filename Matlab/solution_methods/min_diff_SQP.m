function x = min_diff_SQP( image, x0, tol, max_iter )
    I = my_intensity( image, [1, 1, 1]' );

    for k=1:max_iter
        [diff, intensity, F, S] = lagrangian_obj( image, I, x0 );

        x = x0 - (S \ F);

        if diff < tol && abs( I - intensity ) < tol
            break;
        else
            x0 = x;
        end
    end
end