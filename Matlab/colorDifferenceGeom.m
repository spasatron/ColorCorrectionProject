%%Function takes in an image alread in the double format and computes the
%%max of the geomean differences vs the average.
function D = colorDifferenceGeom(image)
    avgs = reshape(geomean(image, [1 2]), [3, 1]);
    totalAv = geomean(avgs);
    D = max(abs(totalAv - avgs));
end