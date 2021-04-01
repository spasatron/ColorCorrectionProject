P = imread( "lily_small.png" );
Q = im2double( P );
N = 50;

gRs = linspace(0, 2, N);
gGs = linspace(0, 2, N);

[GR, GG] = meshgrid( gRs, gGs );
Hs = zeros( size( GR ) );

for i=1:N
    for j=1:N
        Hs(i, j) = entropy( rgb2gray( linearScaling( Q, GR(i, j), GG(i, j), 1 ) ) );
    end
end

contour( GR, GG, Hs )