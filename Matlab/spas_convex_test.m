image = imread('images\lily_small.png');
image = im2double(image);




gamma0 = ones(3, 1);
gammas = fminsearch(@(gamma)colorDifferenceSoftMax(nonlinearScaling(image, gamma(1, 1), gamma(2, 1), gamma(3, 1)), .000001), gamma0);




f1 = imshow(nonlinearScaling(image, gammas(1, 1), gammas(2, 1), gammas(3, 1)));
figure;
f2 = imshow(image);

% A = 0;
% B = 4;
% N = 50;
% 
% h = (B-A)/(N-1);
% 
% x = A:h:B;
% y = A:h:B;
% 
% keyboard;
% [X, Y] = meshgrid(x, y);
% Z = zeros(N, N);
% for i = 1:N
%     for j = 1:N
%         Z(i, j) = colorDifferenceMean(nonlinearScaling(image, x(i), 1, y(j)));
%     end
% end
% 
% mesh(X, Y, Z);