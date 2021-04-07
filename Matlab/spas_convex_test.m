image = imread('images\lily_small.png');
image = im2double(image);




gamma0 = ones(2, 1);
keyboard;
gammas = fminsearch(@(gamma)colorDifferenceMean(nonlinearScaling(image, gamma(1, 1), gammas(2, 1), gammas(3, 1))), gamma0);


f1 = imshow(nonlinearScaling(image, gammas(1, 1), gammas(2, 1), gammas(3, 1)));
figure;
f2 = imshow(image);