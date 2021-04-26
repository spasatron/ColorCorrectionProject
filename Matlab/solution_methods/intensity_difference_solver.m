function g = intensity_difference_solver( image, I, tol_n )
    S = reshape( image, [], 3 );        % Get arrays of scaled
    pixels = reshape( image, [], 3 );   %  and unscaled pixels
    N = size( pixels, 1 );

    % Get nonzero values for variable channels
    Rnz = (pixels(:,1) ~= 0);
    Gnz = (pixels(:,2) ~= 0);
    Bnz = (pixels(:,3) ~= 0);

    % Set initial values
    gr_old = eps;
    gg_old = eps;
    gb_old = eps;
    
    % Select green channel based on intensity
    while true
        S(:, 2) = pixels(:, 2).^gg_old;
        
        gg = gg_old - ( sum(S(:,2)) - N*I ) / ( sum( S(Gnz,2).*log( pixels(Gnz,2) ) ) );
        
        if abs( gg - gg_old ) < tol_n
            break;
        else
            gg_old = gg;
        end
    end

    % Scale gren channel, get its sum
    S(:,2) = pixels(:, 2).^gg;
    const_sum = sum( S(:,2) );

    while true
        S(:, 1) = pixels(:, 1).^gr_old;
        S(:, 3) = pixels(:, 3).^gb_old;
        
        gr = gr_old - ( sum(S(:,1)) - const_sum ) / ( sum( S(Rnz,1).*log(pixels(Rnz,1)) ) );
        gb = gb_old - ( sum(S(:,3)) - const_sum ) / ( sum( S(Bnz,3).*log(pixels(Bnz,3)) ) );
        
        if abs( gr - gr_old ) && abs( gb - gb_old ) < tol_n
            break;
        else
            gr_old = gr;
            gb_old = gb;
        end
    end
    
    g = [gr; gg; gb];
end