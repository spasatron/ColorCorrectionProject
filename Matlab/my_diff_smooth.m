function D = my_diff_smooth( image, g )
    S = reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3);
    D = ln( exp(mean(S) - mean(S, 'all') ).^2 - 2 );
end
