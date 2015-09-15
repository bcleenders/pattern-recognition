function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

accProb = cumsum(pD.ProbMass);
R=zeros(1, nData);

for j=1:nData
    r=rand();
    for i=1:length(accProb)
       if accProb(i) >= r
           R(1, j)=i;
           break;
       end
    end
end