function I = my_intensity( image, g )
    avgs = mean( reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3) );
    I = 0.299*avgs(1) + 0.587*avgs(2) + 0.114*avgs(3);
end