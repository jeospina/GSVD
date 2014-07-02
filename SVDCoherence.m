function ret = SVDCoherence(gmap)

% This code performs the singular value decomposition of the image gradient.
% 
% gmap: image gradient matrix
% 
% This code was taken from:
% 
%X. Zhu and P. Milanfar,“Automatic parameter selection for denoising 
% algorithms using a no-reference measure of image content,” Image 
% Processing, IEEE Transactions on, vol. 19, no. 12, pp. 3116–3132, 2010.
%
%Avalible online at:
% http://www.soe.ucsc.edu/~xzhu/doc/metricq.html

gx = real(gmap);
gy = imag(gmap);

gxvect = gx(:);
gyvect = gy(:);

grad = [gxvect, gyvect];

[~,C,~] = svd(grad,0);

S = diag(C);

s1 = abs(single(S(1)));
s2 = abs(single(S(2)));

ret = [s1 s2];