function hess = diff_quad_penalty_hess( image, I, g, mu )
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
   
    % Compute Jacobian of first derivatives
    grads = [sum( S(Rnz,1) .* log( pixels(Rnz, 1) ) ) ; 
             sum( S(Gnz,2) .* log( pixels(Gnz, 2) ) ) ; 
             sum( S(Bnz,3) .* log( pixels(Bnz, 3) ) ) ];
       
    J = grads .* [ 2, -1, -1; -1,  2, -1; -1, -1,  2 ] / 3 / N; 
         
    % Compute matrix of unmixed second derivatives
    grad2s = [sum( S(Rnz,1) .* log( pixels(Rnz, 1) ).^2 ) ; 
              sum( S(Gnz,2) .* log( pixels(Gnz, 2) ).^2 ) ; 
              sum( S(Bnz,3) .* log( pixels(Bnz, 3) ).^2 ) ];
    J2 = grad2s .* [ 2, -1, -1; -1,  2, -1; -1, -1,  2 ] / 3 / N; 
   
    % Get denominator of smooth max
    hess1 = -4*ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 ).^2;
    hess2 =  2*ones(3, 3) / ( sum( exp( cv.^2 ) ) - 2 );

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
    
    Y_grad = [0.299; 0.587; 0.114] .* grads / N;
    
    hess = hess + mu*(Y_grad*Y_grad') + mu*(Y - I)*diag( [0.299; 0.587; 0.114] .* grad2s ) / N;
end