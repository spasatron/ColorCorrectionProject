function func = diff_quad_penalty( image, I, g, mu )
    S = reshape( image, [], 3 ) .^ (g');
    avgs = mean( S );
    D = log( sum( exp( (avgs - mean(avgs)).^2 ) ) - 2 );
    Y = 0.299*avgs(1) + 0.587*avgs(2) + 0.114*avgs(3);
    
    func = D + 0.5*mu*(Y - I)^2;
end