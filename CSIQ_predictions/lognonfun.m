function [yiw,delta,resids] = lognonfun(metric,DMOS,beta)
if nargin<3
    beta(1)=max(DMOS);
    beta(2)=min(DMOS);
    beta(3)=mean(metric);
    beta(4)=1;
else
    if length(beta)>4
        error('Length of beta is greater than 4')
    else
        switch length(beta)
            case 1
                beta(2)=min(DMOS);
                beta(3)=mean(metric);
                beta(4)=1;
            case 2                
                beta(3)=mean(metric);
                beta(4)=1; 
            case 3                 
                beta(4)=1; 
        end
    end
    if length(x)~=length(y)
        error('Length of the vectors must be equal')
    end
end

% wi=1/std(y);
% ei=x-y;
% eiw=wi*ei;

% model=@(x,beta) wi*((beta(1)-beta(2))./(1+exp((-x+beta(3))/abs(beta(4)))))+eiw;
model=@(beta,x) ((beta(1)-beta(2))./(1+exp((-x+beta(3))./abs(beta(4)))))+beta(2);

[beta0, resids, J] = nlinfit(metric,DMOS,model,beta);

[yiw,delta]=nlpredci(model,metric,beta0,resids,J);

