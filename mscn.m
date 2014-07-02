function im=mscn(imdist)

%This code allows to compute the mean substract contrast normalization to
%the test image. 
% 
% imdist: input color or gray scale image
% 
% This piece of code was extracted from:
% 
% A. Mittal, A. K. Moorthy and A. C. Bovik, "BRISQUE Software Release", 
% URL: http://live.ece.utexas.edu/research/quality/BRISQUE_release.zip, 2011
% 
% A. Mittal, A. K. Moorthy and A. C. Bovik, "No Reference Image Quality Assessment in the Spatial Domain"

    if (size(imdist,3)>1)
        imdist=rgb2gray(imdist);
    end
    imdist=double(imdist);
    
    window = fspecial('gaussian',7,7/6);
    window = window/sum(sum(window));
    
    mu            = filter2(window, imdist, 'same');
    mu_sq         = mu.*mu;
    sigma         = sqrt(abs(filter2(window, imdist.*imdist, 'same') - mu_sq));
    im     = (imdist-mu)./(sigma+1);

