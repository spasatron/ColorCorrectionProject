function [H] = my_entropy( Q )
    Y = im2uint8( rgb2gray( Q ) );
    p = nonzeros( imhist(Y) ) / numel(Y);
    H = -sum( p.*log2(p) );
end