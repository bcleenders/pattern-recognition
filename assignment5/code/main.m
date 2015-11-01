chars = ['A', 'B', 'C', 'i', 'O', 'Q', 'T', 'U', 'V', 'W', '1', '2', '4', '!', '+'];
hmms = {};

numTraining = 20;
numSamples = 30;

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
    if chars(charId) == 'W'
        nStates = 4
    end
    
    hmms{charId} = MakeLeftRightHMM(nStates, GaussMixD(4), charFeatures, lengths);
end

% Get the performance
correct = 0;
incorrect = 0;
for charId= 1:1:length(chars)
    for i= numTraining+1:1:numSamples
        load(sprintf('training_data/features_%s_%.2d', chars(charId), i), 'features');
        
        % Loop over the hmms, pick the most likely one:
        mostLikelyId = 1;
%         [states, score] = hmms{1}.viterbi(features);
        score = hmms{1}.logprob(features);
        mostLikelyScore = score;
        
        for hmmId= 2:1:length(hmms)
%             [states, score] = hmms{hmmId}.viterbi(features);
            score = hmms{hmmId}.logprob(features);
            if(score > mostLikelyScore)
                mostLikelyId = hmmId;
                mostLikelyScore = score;
            end
        end
        
        % Check if we classified correctly
        if mostLikelyId == charId
            correct = correct + 1;
        else
            fprintf('Classified %s incorrectly as %s\n', chars(charId), chars(mostLikelyId));
            incorrect = incorrect + 1;
        end
    end
end

fprintf('Correct: %i\nIncorrect:%i\n', correct, incorrect);
fprintf('Percentage correct: %.2f%%\n', (correct / (correct+incorrect) * 100));
fprintf('Pure chance: %.2f%%\n', (100 / length(hmms)));