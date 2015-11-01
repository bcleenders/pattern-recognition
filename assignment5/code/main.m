char = '+';

charFeatures = [];
lengths = [];

for i= 1:1:12
    load(sprintf('training_data/features_%s_%.2d', char, i), 'features')
    figure1 = features;
    charFeatures = [charFeatures, features];
    lengths = [lengths, length(features)];
end

nStates = 5;
MakeLeftRightHMM(nStates, GaussD, charFeatures, lengths);