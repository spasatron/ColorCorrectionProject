function D = colorDifferenceSoftMax( image , k)
    avgs = reshape( mean( image, [1, 2] ), [3, 1] );
    
    total_avg = mean( avgs );
    D = log(sum(exp(k*(total_avg - avgs).^2)))/k;
end