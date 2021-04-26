function color_histogram( image )
    figure
    [N,e] = histcounts(image(:, :, 1), 256);
    plot(1:(N+1), e, 'r');
    
    hold on
    [N,e] = histcounts(image(:, :, 2), 256);
    e = e(2:end) - (e(2)-e(1))/2;
    plot(e, N, 'g');
    [N,e] = histcounts(image(:, :, 3), 256);
    e = e(2:end) - (e(2)-e(1))/2;
    plot(e, N, 'b');
end