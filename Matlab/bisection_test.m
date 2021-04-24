function gamma = bisection_test(image)

    startInterval = [.5; 10];
    I = my_intensity(image, ones(3, 1));
    tol = 1e-8;
    maxIt = 100;
    LI = my_intensity(image, gamma_newton(image, startInterval(1, 1), 1e-8, 100)) - I;
    for i = 1:maxIt
        
        %RI = my_intensity(image, gamma_newton(image, startInterval(2, 1), 1e-8, 100)) -I;
        gNew = mean(startInterval);
        CI = my_intensity(image, gamma_newton(image, gNew, 1e-8, 100)) - I;
        if(abs(CI) < tol)
            gamma = gamma_newton(image, gNew, 1e-8, 100);
            return;
        end
        if(sign(CI) == sign(LI))
            startInterval(1, 1) = gNew;
            LI = my_intensity(image, gamma_newton(image, startInterval(1, 1), 1e-8, 100)) - I;
        else
            startInterval(2, 1) = gNew;
            
        end
    end
    
    
    
end