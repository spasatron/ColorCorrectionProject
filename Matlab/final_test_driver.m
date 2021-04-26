% Read in image, get initial color difference and intensity
image = im2double( imread( "test_images/lighthouse.png" ) );
I = my_intensity( image, [1, 1, 1]' );
init_diff = my_diff_smooth( image, [1;1;1] );

% Select initial condition and algorithm parameters
x0 = eps*ones(3,1);
v0 = 0;
max_iter = 100;
tol = 1e-10; 

% Test each method
a = linearScalingGammasInt(image, I);
g1 = intensity_difference_solver( image, I, tol );
g2 = min_diff_penalty_newton( image, x0, 10, tol, max_iter );
g3 = min_diff_SQP( image, [x0; v0], tol, max_iter);

figure(1)
montage( {image, linearScaling(image, a), nonlinearScaling(image, g1)}, 'Size', [1 3] );