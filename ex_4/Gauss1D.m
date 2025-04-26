function val = Gauss1D(xPoints, dMean, dStd);
% get distribution function 
val = (1/ (sqrt(2 * pi) * dStd) ) * exp( -(xPoints - dMean).^2/(2 * dStd^2));
