function D = my_diff_smooth( image, g )
    S = reshape( image, [], 3) .^ (g');
    D = log( sum( exp( (mean(S) - mean(S, 'all') ).^2 ) ) - 2 );
end
