image = im2double(imread("images/lily_small.png"));

x0 = 5*[1;1;1;];
v0 = 1;

X = [x0;v0];

g = min_diff_SQP(image, X, 1e-10, 1000);

montage({image, nonlinearScaling(image, g(1,1), g(2, 1),g(3, 1))});
