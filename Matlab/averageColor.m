
%%%%%
%AverageColortest takes an input image and calculates the maximum
%difference between the red, green, and blue averages when compared to the
%total average. Output is a number between 0 and 255.
function difference = averageColor(image)
    [height, width, ~] = size(image);
    Rbar = sum(image(:, :, 1), 'all')/(height*width);
    Gbar = sum(image(:, :, 2), 'all')/(height*width);
    Bbar = sum(image(:, :, 3), 'all')/(height*width);
    Mbar = (Rbar + Gbar + Bbar)/3;
    difference = max([abs(Rbar - Mbar); abs(Gbar - Mbar); abs(Bbar - Mbar)]);
end