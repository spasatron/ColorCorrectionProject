function D = my_diff( image, g )
    S = reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3);
    D = max( (mean(S) - mean(S, 'all') ).^2 );
end
