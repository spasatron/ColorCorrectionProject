function I = my_intensity( image, g )
    avgs = mean( reshape( image, [], 3 ) .^ (g') );
    I = 0.299*avgs(1) + 0.587*avgs(2) + 0.114*avgs(3);
end