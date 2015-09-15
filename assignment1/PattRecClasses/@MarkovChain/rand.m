function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

currState = DiscreteD(mc.InitialProb).rand(1);
S(1,1) = currState;

for i= 2:T
    currState = DiscreteD(mc.TransitionProb(currState,:)).rand(1);
    if currState == nS+1
        S = S(1,1:i-1);
        break
    end
    S(1,i) = currState;
end

