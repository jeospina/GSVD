function mp = AnisoSetEst(img, N)

% This code returns a mask to identify the anisotropic patches in the test
% image.
% 
% img: input gray scale image
% N: patch size
% 
% This code was taken from:
% 
%X. Zhu and P. Milanfar,“Automatic parameter selection for denoising 
% algorithms using a no-reference measure of image content,” Image 
% Processing, IEEE Transactions on, vol. 19, no. 12, pp. 3116–3132, 2010.
%
%Avalible online at:
% http://www.soe.ucsc.edu/~xzhu/doc/metricq.html


[H W] = size(img);

w = floor(W/N);
h = floor(H/N);

mp = zeros(h,w);
alph = 0.001;
thresh = alph^(1/(N^2-1));
thresh = sqrt((1-thresh)/(1+thresh));

for m = 1:h
    for n = 1:w
        AOI = img(N*(m-1)+1:N*m, N*(n-1)+1:N*n);
        
        [gx, gy] = gradient(AOI);
        G=gx+i*gy;
        ret = SVDCoherence(G);
        co = ret(1);
        
        if co > thresh
            mp(m,n) = 1;
        end
        
    end
end
