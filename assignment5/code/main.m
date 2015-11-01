char = 'T';

charFeatures = [];
lengths = [];

for i= 1:1:12
    load(sprintf('training_data/features_%s_%.2d', char, i), 'features');
    charFeatures = [charFeatures features];
    lengths = [lengths length(features)];
end

for i= 1:1:length(charFeatures)
    for j= 1:1:4
        charFeatures(j, i) = charFeatures(j, i) + (rand() - 0.5)/100;
    end
end

nStates = 3;
hmm = MakeLeftRightHMM(nStates, GaussMixD(4), charFeatures, lengths);

load(sprintf('training_data/features_%s_%.2d', char, 13), 'features');
hmm.logprob(features)