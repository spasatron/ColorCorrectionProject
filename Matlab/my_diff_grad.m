function grad = my_diff_grad( image, g )
    % Scale image, get averages
    S = reshape( image, [], 3) .^ (g');
    cv = mean( S ) - mean( S, 'all' );
    
    % Get nonzero pixel values for gradient
    pixels = reshape( image, [], 3 );
    N = size( pixels, 1 );
    
    % Get nonzero values for each channel
    Rnz = nonzeros(pixels(:,1));
    Gnz = nonzeros(pixels(:,2));
    Bnz = nonzeros(pixels(:,3));
    
    % Get denominator of smooth max
    grad = [sum( Rnz.^g(1) .* log( Rnz ) ) ; 
            sum( Gnz.^g(1) .* log( Gnz ) ) ; 
            sum( Bnz.^g(1) .* log( Bnz ) ) ]; 
    
    % Compute gradient
    grad = 2 * grad / ( sum( exp( cv.^2 ) ) - 2) / 3 / N;
    grad = grad .* [2, -1, -1; -1, 2, -1; -1, -1, 2 ] * (exp( cv.^2 ).*cv)';

end
