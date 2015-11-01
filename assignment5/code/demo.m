chars = ['A', 'B', 'C', 'i', 'O', 'Q', 'T', 'U', 'V', 'W', '1', '2', '4', '!', '+'];
hmms = {};

numTraining = 30;
numSamples = 30;

maxtime = 4;

% Train all the HMMs
for charId= 1:1:length(chars)
    currChar = chars(charId);
    charFeatures = [];
    lengths = [];

    for i= 1:1:numTraining
        load(sprintf('training_data/features_%s_%.2d', currChar, i), 'features');
        charFeatures = [charFeatures features];
        lengths = [lengths length(features)];
    end

    for i= 1:1:length(charFeatures)
        for j= 1:1:4
            charFeatures(j, i) = charFeatures(j, i) + (rand() - 0.5)/100000;
        end
    end

    nStates = 3;
     
    hmms{charId} = MakeLeftRightHMM(nStates, GaussMixD(3), charFeatures, lengths);
end

while 1
    figure = DrawCharacter(maxtime);
    features = FeatureExtractor(figure);

    % Loop over the hmms, pick the most likely one:
    mostLikelyId = 1;
    score = hmms{1}.logprob(features);
    mostLikelyScore = score;

    for hmmId= 2:1:length(hmms)
        score = hmms{hmmId}.logprob(features);
        if(score > mostLikelyScore)
            mostLikelyId = hmmId;
            mostLikelyScore = score;
        end
    end

    fprintf('I think you wrote %s\n', chars(mostLikelyId));
end
