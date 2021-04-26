function Q_scaled = linearScaling( Q, g )
    Q_scaled = Q .* cat( 3, g(1), g(2), g(3) );
end