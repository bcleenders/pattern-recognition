num=500;

%Generate ones and twos
% mc2=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
% onesTwos=rand(mc2, num);
% percentageTwos=(sum(onesTwos)-num)/num*100;
% disp(['percentage of ones: ', num2str(100-percentageTwos), '%']);
% disp(['percentage of twos: ', num2str(percentageTwos), '%']);

%Generate random numbers from "randomly" chosen distributions
% mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
% g1=GaussD('Mean',0,'StDev',1); %distr for state 1
% g2=GaussD('Mean',0,'StDev',2); %distr for state 2
% h=HMM(mc, [g1; g2]);
% x=rand(h, num);
% %Get statistics about the numbers
% disp(['mean:     ', num2str(mean(x))]);
% disp(['variance: ', num2str(var(x))]);

% Question 4/5 -> plot output of random function
% figure
% plot(x)
% title('HMM output')
% xlabel('iteration')
% ylabel('value')

% Question 5 -> plot probability distributions
% x = [-5:.1:5];
% norm1 = normpdf(x,0,1);
% norm2 = normpdf(x,0,2);
% figure;
% plot(x,norm1); hold on;
% plot(x,norm2);
% xlabel('output value')
% ylabel('probability')

% Question 6: finite sequences
% finitemc=MarkovChain([0.75;0.25], [0.88 0.1 0.02;0.09 0.9 0.01]);
% g1=GaussD('Mean',0,'StDev',1); %distr for state 1
% g2=GaussD('Mean',3,'StDev',2); %distr for state 2
% h=HMM(finitemc, [g1; g2]);
% x=rand(h, num);
% disp(['We asked for a sequence of length ', num2str(num), ', but got length ', num2str(length(x))]);
% plot(x)

% Question 7: returning vectors
finitemc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
g1=GaussD('Mean',[0 1],'Covariance',[2 1;1 4]); %distr for state 1
g2=GaussD('Mean',[3 9],'Covariance',[1 4;4 1]); %distr for state 2
h=HMM(finitemc, [g1; g2]);
x=rand(h, num);
plot(x)