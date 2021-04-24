function grad = diff_quad_penalty_grad( image, I, g, mu )
    % Scale image, get averages
    S = reshape( image, [], 3) .^ (g');
    avgs = mean( S );
    cv = avgs - mean( avgs ); % Get components of scaled image
    Y = 0.299*avgs(1) + 0.587*avgs(2) + 0.114*avgs(3); % Get new intensity

    % Get nonzero pixel values for gradient
    pixels = reshape( image, [], 3 );
    N = size( pixels, 1 );
    
    % Get nonzero values for each channel
    Rnz = (S(:,1) ~= 0);
    Gnz = (S(:,2) ~= 0);
    Bnz = (S(:,3) ~= 0);
    
    % Get derivatives of component functions
    J = [sum( S(Rnz,1) .* log( pixels(Rnz, 1) ) ) ; 
         sum( S(Gnz,2) .* log( pixels(Gnz, 2) ) ) ; 
         sum( S(Bnz,3) .* log( pixels(Bnz, 3) ) ) ]; 
    
    % Compute gradient
    grad = 2 * J / ( sum( exp( cv.^2 ) ) - 2) / 3 / N;
    grad = grad .* [2, -1, -1; -1, 2, -1; -1, -1, 2 ] * (exp( cv.^2 ).*cv)';
    
    % Add penalty component
    grad = grad + mu*( Y - I )*[0.299; 0.587; 0.114] .* J / N;   
end