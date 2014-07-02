function [score,feat]=gsvd(img,aniso)

% This code returns the image quality score and features f1=mode(H(s1s2)) 
% and f2=max(H(s1s2)) of histogram H(s1s2) of the test image.
% 
% If the quality score are compute only with anisotropic patches 'aniso' 
% must be '1', otherwise must be '0'.
% 
% If the quality score are compute with a different model, the variable 
% must be named as 'model'. Then, the line number 24 must be changed by the file
% name.
% 
% img: input color or gray scale image
% aniso: '1'        - anisotropic patches
%        '0'        - all patches
% 
% Anisotropic patches and the singular value decomposition are computing
% using code pieces taken from:
% 
%X. Zhu and P. Milanfar,“Automatic parameter selection for denoising 
% algorithms using a no-reference measure of image content,” Image 
% Processing, IEEE Transactions on, vol. 19, no. 12, pp. 3116–3132, 2010.
%
%Avalible at:
% http://www.soe.ucsc.edu/~xzhu/doc/metricq.html

if nargin==1
    aniso=0;
    load('model_gsvd.mat')
else
    load('model_gsvd.mat')
end

%Parameters
bins=100; %Number of histogram points
N=8; %size of patch


%% normalization
img=mscn(img);

[H,W]=size(img);
w = floor(W/N);
h = floor(H/N);

%% Compute parameters with Anisotropic Patches
if aniso==1    
    map=AnisoSetEst(img,N);
    num_patch=0;
    for m=1:h
        for n=1:w
            if map==0
                continue
            end
            num_patch=num_patch+1;
            AOI = img(N*(m-1)+1:N*m, N*(n-1)+1:N*n);
            [gx, gy] = gradient(AOI);
            G=gx+i*gy;
            ret = SVDCoherence(G);
            s1 = ret(1);  
            s2= ret(2);
            feat(num_patch)=s1*s2;
        end
    end

%% Compute parameters with all patches
elseif aniso==0
    num_patch=0;
    for m=1:h
        for n=1:w        
            num_patch=num_patch+1;
            AOI = img(N*(m-1)+1:N*m, N*(n-1)+1:N*n);
            [gx, gy] = gradient(AOI);
            G=gx+i*gy;
            ret = SVDCoherence(G);
            s1 = ret(1);
            s2= ret(2);
            feat(num_patch)=s1*s2;
        end
    end

else
    error('aniso must be 0 or 1')
end

%% compute features
maxs4=max(feat);
[freq,center]=hist(feat,bins);            
[~,ith]=max(freq);
modes4=center(ith);


%% euclidean distance
score=distances(model.mu,[modes4;maxs4]); 
        
function y=distances(model_point,point)
        y=sqrt((model_point(1)-point(1))^2+(model_point(2)-point(2))^2);
        