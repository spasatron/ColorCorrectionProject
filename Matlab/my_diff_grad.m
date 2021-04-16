function grad = my_diff_grad( image, g )
    % Scale image, get averages
    S = reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3);
    N = size( S, 1 );
    cv = mean(S) - mean(S, 'all');

    % Create cell array of nonzero values
    S = { nonzeros(S(:,1)), nonzeros(S(:,2)), nonzeros(S(:,3)) };
    
    % Get denominator of smooth max
    grad = 2 * ones(3, 1) / ( sum( exp( cv.^2 ) ) - 2);
    
    % Compute gradient as dot product 
    grad(1) = grad(1)*dot( cellfun( @(Si) sum( Si.^g(1) .* log( Si ) ), S ).*[2, -1, -1]/3/N, exp( cv.^2 ).*cv );
    grad(2) = grad(2)*dot( cellfun( @(Si) sum( Si.^g(2) .* log( Si ) ), S ).*[-1, 2, -1]/3/N, exp( cv.^2 ).*cv );
    grad(3) = grad(3)*dot( cellfun( @(Si) sum( Si.^g(3) .* log( Si ) ), S ).*[-1, -1, 2]/3/N, exp( cv.^2 ).*cv );
    
end
