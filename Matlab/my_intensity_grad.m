function grad = my_intensity_grad( image, g )
    % Scale image, get averages
    S = reshape( image, [], 3);
    N = size( S, 1 );
    
    % Create cell array of nonzero values
    S = { nonzeros(S(:,1)), nonzeros(S(:,2)), nonzeros(S(:,3)) };
    grad = zeros(3, 1);
    
    % Compute gradient as dot product 
    grad(1) = 0.299 * sum( S{1}.^g(1) .* log( S{1} ) ) / N;
    grad(2) = 0.587 * sum( S{2}.^g(2) .* log( S{2} ) ) / N;
    grad(3) = 0.114 * sum( S{3}.^g(3) .* log( S{3} ) ) / N;
end
