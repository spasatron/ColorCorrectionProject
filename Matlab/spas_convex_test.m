image = imread('images\lily.png');
image = im2double(image);




% gamma0 = ones(3, 1);
% gammas = fminsearch(@(gamma)colorDifferenceSoftMax(nonlinearScaling(image, gamma(1, 1), gamma(2, 1), gamma(3, 1)), .000001), gamma0);
% 
% 
% 
% 
% f1 = imshow(nonlinearScaling(image, gammas(1, 1), gammas(2, 1), gammas(3, 1)));
% figure;
% f2 = imshow(image);

% % % % % % Bisection method
% % gammas = bisection_test(image);
% % 
% % f1 = imshow(nonlinearScaling(image, gammas(1,1), gammas(2,1), gammas(3, 1)));
% % int = my_intensity(image, gammas(1:3)) - my_intensity(image, ones(1, 3));
% % colorDif = colorDifferenceMean(nonlinearScaling(image, gammas(1,1), gammas(2,1), gammas(3, 1)));



gammas = grad_desc(@(g)my_diff_smooth(image, g(1:3)), @(g)my_diff_grad(image, g(1:3)), ones(3, 1), 1e-10, 1000, .1);