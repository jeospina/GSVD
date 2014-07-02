% This code computes the reference model for GSVD.
% To run the code, Pristine image database used for compute the NIQE(1)(2) model must be located in this
% folder. These images can be obtained from:
% 
% http://live.ece.utexas.edu/research/quality/pristinedata.zip
% 
%(1) A. Mittal, R. Soundararajan and A. C. Bovik, "NIQE Software Release", 
% URL: http://live.ece.utexas.edu/research/quality/niqe.zip, 2012.
% 
%(2) A. Mittal, R. Soundararajan and A. C. Bovik, "Making a Completely Blind 
% Image Quality Analyzer", submitted to IEEE Signal Processing Letters, 
% 2012.
% 
% Expectation maximization algorithm was obtained from:
% 
% http://www.mathworks.com/matlabcentral/fileexchange/downloads/334913/download


%% NIQE-DATABASE Pristine Images
addpath ./emgm
mode_gsvd=[];
max_gsvd=[];
for num=1:500
    disp(sprintf('NIQE-Database iter: %d',num))
    
    if exist(sprintf('./pristine/img%d.bmp',num),'file')~=0
        img=double(imread(sprintf('./pristine/img%d.bmp',num)));        
    elseif exist(sprintf('./pristine/img%d.jpg',num),'file')~=0
        img=double(imread(sprintf('./pristine/img%d.jpg',num)));       
    else
        continue;
    end
    
    [~,feat]=gsvd(img,1);
%     save(sprintf('./features/NIQE_feat%d.mat',num),'feat')     
    
    max_gsvd=[max_gsvd,max(feat)];
    
    if length(feat)>1            
        [freq,center]=hist(feat,100);            
        [~,i]=max(freq);
        mode_gsvd=[mode_gsvd,center(i)];
    else
        mode_gsvd=[mode_gsvd,temp];
    end

end

data=[mode_gsvd;max_gsvd];
[~,model,~]=emgm(data,1);
save('model_new.mat','model')


