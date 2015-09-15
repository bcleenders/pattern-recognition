%Example: Define and use a simple infinite-duration HMM
mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97])%State generator
g1=GaussD('Mean',0,'StDev',1) %Distribution for state=1
g2=GaussD('Mean',2,'StDev',3) %Distribution for state=2
h=HMM(mc, [g1; g2]) %The HMM
x=rand(h, 100); %Generate an output sequence
% 
% ProbMas = [0.1, 0.1, 0.7, 0.1];
% nData=100;
% accProb = cumsum(ProbMas);
% R=zeros(1, nData);
% 
% for j=1:nData
%     r=rand();
%     for i=1:length(accProb)
%        if accProb(i) >= r
%            R(1, j)=i;
%            break;
%        end
%     end
% end
% R