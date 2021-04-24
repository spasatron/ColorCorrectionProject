function gammas = linearScalingGammas(img)

    means = mean(img, [1,2]);
    gammas = ones(3, 1);
    
    gammas(1, 1) = means(1, 1, 2)/means(1, 1, 1);
    gammas(3, 1) = means(1, 1, 2)/means(1, 1, 3);
    
end