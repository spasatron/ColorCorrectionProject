function hess = my_diff_hess( image, g )
    % Scale image, get averages
    S = reshape( image .^ cat( 3, g(1), g(2), g(3) ), [], 3);
    N = size( S, 1 );
    cv = mean(S) - mean(S, 'all');

    % Create cell array of nonzero values
    S = { nonzeros(S(:,1)), nonzeros(S(:,2)), nonzeros(S(:,3)) };
    
    % Get denominator of smooth max
    hess1 = -ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 ).^2;
    hess2 = 2*ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 );
    
    J = zeros(3, 3);
    J2 = zeros(3, 3);
    
    % Compute Jacobian to get partial derivatives
    J(1, :) = cellfun( @(Si) sum( Si.^g(1) .* log( Si ) ), S ).*[2, -1, -1]/3/N;
    J(2, :) = cellfun( @(Si) sum( Si.^g(2) .* log( Si ) ), S ).*[-1, 2, -1]/3/N;
    J(3, :) = cellfun( @(Si) sum( Si.^g(3) .* log( Si ) ), S ).*[-1, -1, 2]/3/N;
    
    % Compute derivative of each row of Jacobian with respect to g1, g2, g3
    J(1, :) = cellfun( @(Si) sum( Si.^g(1) .* log( Si ).^2 ), S ).*[2, -1, -1]/3/N;
    J(2, :) = cellfun( @(Si) sum( Si.^g(2) .* log( Si ).^2 ), S ).*[-1, 2, -1]/3/N;
    J(3, :) = cellfun( @(Si) sum( Si.^g(3) .* log( Si ).^2 ), S ).*[-1, -1, 2]/3/N;
    
    hess1(1,1) = hess1(1,1)*sum( 2*exp( cv.^2 ) .* cv .* J(1, :) ).^2;
    hess2(1,1) = hess2(1,1)*sum(   exp( cv.^2 ) .* ( J(1,:).^2 + cv.*J2(1,:) + 2*cv.^2.*J(1,:).^2 ) );

    hess1(2,2) = hess1(2,2)*sum( 2*exp( cv.^2 ) .* cv .* J(2, :) ).^2;
    hess2(2,2) = hess2(2,2)*sum(   exp( cv.^2 ) .* ( J(2,:).^2 + cv.*J2(2,:) + 2*cv.^2.*J(2,:).^2 ) );

    hess1(3,3) = hess1(3,3)*sum( 2*exp( cv.^2 ) .* cv .* J(3, :) ).^2;
    hess2(3,3) = hess2(3,3)*sum(   exp( cv.^2 ) .* ( J(3,:).^2 + cv.*J2(3,:) + 2*cv.^2.*J(3,:).^2 ) );

    hess1(1,2) = hess1(3,3)*sum( 2*exp( cv.^2 ).*cv.*J(1, :) )*sum( 2*exp( cv.^2 ).*cv.*J(2, :) );
    hess2(1,2) = hess2(3,3)*sum(   exp( cv.^2 ).*J(1,:).*J(2,:).*(1 + 2*cv.^2) );

    hess1(1,3) = hess1(3,3)*sum( 2*exp( cv.^2 ).*cv.*J(1, :) )*sum( 2*exp( cv.^2 ).*cv.*J(3, :) );
    hess2(1,3) = hess2(3,3)*sum(   exp( cv.^2 ).*J(1,:).*J(3,:).*(1 + 2*cv.^2) );

    hess1(2,3) = hess1(3,3)*sum( 2*exp( cv.^2 ).*cv.*J(2, :) )*sum( 2*exp( cv.^2 ).*cv.*J(3, :) );
    hess2(2,3) = hess2(3,3)*sum(   exp( cv.^2 ).*J(2,:).*J(3,:).*(1 + 2*cv.^2) );

    % Recover symmetry
    hess1(2,1) = hess1(1, 2);   hess2(2,1) = hess2(1, 2);
    hess1(3,1) = hess1(1, 3);   hess2(3,1) = hess2(1, 3);
    hess1(3,2) = hess1(2, 3);   hess2(3,2) = hess2(2, 3);

    hess = hess1 + hess2;
end
