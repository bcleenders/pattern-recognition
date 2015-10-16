maxtime = 5;

chars = ['B'];% 'C'];% 'Q' 'P' 'b' 'T' '+' 'U' 'V' 'W'];

for c=1:1:length(chars)
    for i=1:1:15
        
        disp(sprintf('Write %s (%d)', chars(c), i));
        
        figure = DrawCharacter(maxtime);
        features = FeatureExtractor(figure);
        
        save(sprintf('training_data/figure_%s_%.2d.mat', chars(c), i));
        save(sprintf('training_data/features_%s_%.2d.mat', chars(c), i));
    end
end
%plot(transpose(features));
%features