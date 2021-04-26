% Test fmincon
piximage = imread( "test_images/food.png" );
image = im2double( piximage );

I = my_intensity( image, [1, 1, 1]' );
diff_quad_penalty( image, I, [1;1;1], 12 );

options = optimoptions('fmincon', 'Algorithm', 'interior-point', ...
    'SpecifyConstraintGradient', true, 'SpecifyObjectiveGradient', true, ...
    'OptimalityTolerance', tol);
    
x0 = [0.5;0.5;0.5];
lb = [0;0;0];
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon( @(g) my_diff_smooth(image, g), x0, [], [], [], [], lb, [], @(g) image_nlcon(image, I, g), options );

figure(1)
montage( {image, nonlinearScaling( image, x )} );
title( sprintf( "Original: Color Diff = %e\nCorrected: Color Diff = %e,    Intensity Diff = %e", ...
        my_diff( image, [1;1;1] ), my_diff( image, x ), my_intensity( image, g1(1:3) ) - my_intensity( image, [1,1,1]' ) ) );
