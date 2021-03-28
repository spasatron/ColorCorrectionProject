


image = imread('images\lily_small.png');
imshow(image);



x = .001:.01:2;
y = .001:.01:2;

[X, Y] = meshgrid(x, y);
keyboard;
Z = zeros(200, 200);

for i = 1:200
    for j = 1:200
       Z(i, j) = averageColor(scaleWithGamma([X(i, j); Y(i, j);1], image)); 
    end
end

mesh(X, Y, Z);


function outputImage = scaleWithGamma(gamma, image)
    %%Red Gamma Scalling
    outputImage = im2double(image);
    outputImage(:, : ,1) = (outputImage(:, :, 1)/255).^(gamma(1, 1))*255;
    outputImage(:, : ,2) = (outputImage(:, :, 2)/255).^(gamma(2, 1))*255;
    outputImage(:, : ,3) = (outputImage(:, :, 3)/255).^(gamma(3, 1))*255;
end