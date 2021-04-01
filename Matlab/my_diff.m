function D = my_diff( image )
    avgs = reshape( mean( image, [1, 2] ), [3, 1] );
    total_avg = mean( avgs );
    D = max(abs( avgs - total_avg ));
end