% This code computes: PLCC, SRCC, KCC and RMSE between predictions and dmos
% of CSIQ database
% 
% Line 6 must be modified to compute these coefficients with other metric prediction.

load gsvd.mat % predictions of metric GSVD. Other metric predictions are available as: 
%               BRISQUE
%               BLIINDSII
%               JNBM
%               S3
%               CPBD
%               LPC-SI
%               METRICQ
%               MSSIM
%               PSNR
%               AN_VAR, which is the image quality assessment metric based on anisotropy-variance

load dmos.mat

Qall=[Qwn,Qblur];
dmoswn=dmosall(1:150);
dmosblur=dmosall(151:300);

%% wn
Qwn=scale_metric(Qwn);
[y,~,~]=lognonfun(Qwn,dmoswn);
cs=corr(y,dmoswn','type','spearman');
cp=corr(y,dmoswn','type','pearson');
ck=corr(y,dmoswn','type','kendall');
rmse=sqrt(sum((y-dmoswn').^2)/length(y))/10;
fprintf('\nwn:\tcp\tcs\tck\trmse\n');
fprintf('\t\t%4.4f\t%4.4f\t%4.4f\t%4.4f\n',cp,cs,ck,rmse)

%% blur
Qblur=scale_metric(Qblur);
% dmosblur=scale_metric(dmosblur);
[y,~,~]=lognonfun(Qblur,dmosblur);
cs=corr(y,dmosblur','type','spearman');
cp=corr(y,dmosblur','type','pearson');
ck=corr(y,dmosblur','type','kendall');
rmse=sqrt(sum((y-dmosblur').^2)/length(y))/10;
fprintf('\nblur:\tcp\tcs\tck\trmse\n');
fprintf('\t\t%4.4f\t%4.4f\t%4.4f\t%4.4f\n',cp,cs,ck,rmse)

%% all
Qall=scale_metric(Qall);
% dmosall=scale_metric(dmosall);
[y,~,~]=lognonfun(Qall,dmosall);
cs=corr(y,dmosall','type','spearman');
cp=corr(y,dmosall','type','pearson');
ck=corr(y,dmosall','type','kendall');
rmse=sqrt(sum((y-dmosall').^2)/length(y))/10;
fprintf('\nALL:\tcp\tcs\tck\trmse\n');
fprintf('\t\t%4.4f\t%4.4f\t%4.4f\t%4.4f\n',cp,cs,ck,rmse)

fprintf('\nmean time (s):\t%2.4f\n',mean(time));