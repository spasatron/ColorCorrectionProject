function grad = my_diff_grad( image, g )
    % Scale image, get averages
    S = reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3);
    diff_vec = mean( S );

    % Get denominator of smooth max
    grad = 2*ones(3, 1) / ( sum( exp( diff_vec.^2 ) ) - 2);
    
    Jac = [0,0,0];
    for k=1:3
        Jac(1) = sum( nonzeros(S(:,1)).^g(k) .* log(nonzeros(S(:,1))) );
        Jac(2) = sum( nonzeros(S(:,2)).^g(k) .* log(nonzeros(S(:,2))) );
        Jac(3) = sum( nonzeros(S(:,3)).^g(k) .* log(nonzeros(S(:,3))) );
        
        grad(k) = grad(k) * dot( Jac .* circshift([-1, -1, 2], k) / size( S, 1 ), exp( diff_vec.^2 ).*diff_vec );
    end
end
