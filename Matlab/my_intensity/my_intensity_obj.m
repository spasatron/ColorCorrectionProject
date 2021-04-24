function [func, grad] = my_intensity_obj( image, g )
    % Scale image, get averages
    S = reshape( image, [], 3) .^ (g');
    avgs = mean( S );
    
    % Get new intensity
    func = 0.299*avgs(1) + 0.587*avgs(2) + 0.114*avgs(3); 
    
    if nargout >= 1
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

        % get gradient
        grad = [0.299; 0.587; 0.114] .* J / N;   
    end
end