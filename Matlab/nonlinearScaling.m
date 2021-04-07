function Q_scaled = nonlinearScaling( Q, gR, gG, gB )
    Q_scaled = Q .^ cat( 3, gR, gG, gB );
end
