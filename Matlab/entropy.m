% Function to compute the total entropy of a color corrected image
function [H] = entropy( Gr, Gg, Gb )
    P = imread("lily_small.png");
    Q = double(P) / 255;
    % Get intensity channel of adjusted image
    Y = 255 * ( 0.299*Q(:,:, 1).^Gr + 0.587*Q(:,:, 2).^Gg + 0.114*Q(:,:,3).^Gb );
    p = nonzeros( histcounts(Y, 256) ) / numel(Y);
    H = -sum( p.*log2(p) );
end
