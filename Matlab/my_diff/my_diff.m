function D = my_diff( image, g )
    S = reshape( image, [], 3) .^ (g');
    D = max( (mean(S) - mean(S, 'all') ).^2 );
end