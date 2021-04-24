function gammas = linearScalingGammasInt(img, int)

    means = mean(img, [1,2]);
    gammas = ones(3, 1);
    
    gammas(1, 1) = int/means(1, 1, 1);
    gammas(2, 1) = int/means(1, 1, 2);
    gammas(3, 1) = int/means(1, 1, 3);
    
end