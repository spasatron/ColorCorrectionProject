%%Function takes in an image already in the double format and computes the
%%max of the mean differences vs the average.

function D = colorDifferenceMean(image)
    avgs = reshape( mean( image, [1, 2] ), [3, 1] );
    total_avg = mean( avgs );
    D = max(abs( avgs - total_avg ));
end