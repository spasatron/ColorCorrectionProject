function Q_scaled = linearScaling( Q, gR, gG, gB )
    Q_scaled = Q.*cat(3, gR, gG, gB);
end