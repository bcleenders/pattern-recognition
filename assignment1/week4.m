% Verification of forward algorithm
%Assignment A.4.1

% Given c for backward algorithm : 

mc=MarkovChain([1;0], [0.9 0.1 0;0 0.9 0.1]);
g1=GaussD('Mean',0,'StDev',1);
g2=GaussD('Mean',3,'StDev',2);
h=HMM(mc, [g1; g2]);
x = [-0.2 2.6 1.3];
pX = h.OutputDistr.prob(x);

cGiven = [1 0.1625 0.8266 0.0581];
alfaHatGiven = [1.0000 0.3847 0.4189; 0 0.6153 0.5811];

[alfaHat,c]=forward_correctme(mc,pX);
c= round(c,4);
alfaHat=round(alfaHat,4);

if(~isequal(c,cGiven'))
    disp(sprintf('Incorrect c values'));
else 
    disp(sprintf('C Values match correctly!!'));
end
if(~isequal(alfaHat,alfaHatGiven))
    disp(sprintf('Incorrect alfaHat values')); 
else
    disp(sprintf('AlfaHat values match correctly!!'));
end


