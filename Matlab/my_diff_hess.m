function hess = my_diff_hess( image, g )
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
    hess1 = -4*ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 ).^2;
    hess2 =  2*ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 );
    
  
    % Compute Jacobian of first derivatives
    J = [sum( Rnz.^g(1) .* log( Rnz ) ) ; 
         sum( Gnz.^g(2) .* log( Gnz ) ) ; 
         sum( Bnz.^g(3) .* log( Bnz ) ) ] .* ...
        [ 2, -1, -1;
         -1,  2, -1;
         -1, -1,  2 ] / 3 / N; 
         
    % Compute matrix of unmixed second derivatives
    J2 = [sum( Rnz.^g(1) .* log( Rnz ).^2 ) ; 
          sum( Gnz.^g(1) .* log( Gnz ).^2 ) ; 
          sum( Bnz.^g(1) .* log( Bnz ).^2 ) ] .* ...
        [ 2, -1, -1;
         -1,  2, -1;
         -1, -1,  2 ] / 3 / N; 
    
    hess1(1,1) = hess1(1,1)*sum( exp( cv.^2 ) .* cv .* J(1, :) ).^2;
    hess2(1,1) = hess2(1,1)*sum( exp( cv.^2 ) .* ( J(1,:).^2 + cv.*J2(1,:) + 2*cv.^2.*J(1,:).^2 ) );

    hess1(2,2) = hess1(2,2)*sum( exp( cv.^2 ) .* cv .* J(2, :) ).^2;
    hess2(2,2) = hess2(2,2)*sum( exp( cv.^2 ) .* ( J(2,:).^2 + cv.*J2(2,:) + 2*cv.^2.*J(2,:).^2 ) );

    hess1(3,3) = hess1(3,3)*sum( exp( cv.^2 ) .* cv .* J(3, :) ).^2;
    hess2(3,3) = hess2(3,3)*sum( exp( cv.^2 ) .* ( J(3,:).^2 + cv.*J2(3,:) + 2*cv.^2.*J(3,:).^2 ) );

    hess1(1,2) = hess1(1,2)*sum( exp( cv.^2 ).*cv.*J(1, :) )*sum( exp( cv.^2 ).*cv.*J(2, :) );
    hess2(1,2) = hess2(1,2)*sum( exp( cv.^2 ).*J(1,:).*J(2,:).*(1 + 2*cv.^2) );

    hess1(1,3) = hess1(1,3)*sum( exp( cv.^2 ).*cv.*J(1, :) )*sum( exp( cv.^2 ).*cv.*J(3, :) );
    hess2(1,3) = hess2(1,3)*sum( exp( cv.^2 ).*J(1,:).*J(3,:).*(1 + 2*cv.^2) );

    hess1(2,3) = hess1(2,3)*sum( exp( cv.^2 ).*cv.*J(2, :) )*sum( exp( cv.^2 ).*cv.*J(3, :) );
    hess2(2,3) = hess2(2,3)*sum( exp( cv.^2 ).*J(2,:).*J(3,:).*(1 + 2*cv.^2) );

    % Recover symmetry
    hess1(2,1) = hess1(1, 2);   hess2(2,1) = hess2(1, 2);
    hess1(3,1) = hess1(1, 3);   hess2(3,1) = hess2(1, 3);
    hess1(3,2) = hess1(2, 3);   hess2(3,2) = hess2(2, 3);

    hess = hess1 + hess2;
end
