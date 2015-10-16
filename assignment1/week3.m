mc=MarkovChain([1;0], [0.9 0.1 0;0 0.9 0.1]);
g1=GaussD('Mean',0,'StDev',1);
g2=GaussD('Mean',3,'StDev',2);
h=HMM(mc, [g1; g2]);

x = [-0.2 2.6 1.3];
c = [1, 0.1625 0.8266 0.0581];

% Height equal to number of states, length equal to number of observations
% pX(i, t) is P(X(t) = x(t) | S = i)
pX = h.OutputDistr.prob(x);

% Output should be:
%betaHat =
%    1.0003    1.0393         0
%    8.4182    9.3536    2.0822
bh = mc.backward(pX, c)