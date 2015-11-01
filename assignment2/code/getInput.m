maxtime = 3;

chars = ['+'];
% 'U', 'V', 'W', '1', '2', '4', '!', '+'];

for c=1:1:length(chars)
    for i=16:1:30
        
        disp(sprintf('Write %s (%d)', chars(c), i));
        
        figure = DrawCharacter(maxtime);
        features = FeatureExtractor(figure);
        
%         save(sprintf('training_data/figure_%s_%.2d.mat', chars(c), i));
        save(sprintf('./training_data/features_%s_%.2d.mat', chars(c), i));
    end
end
%plot(transpose(features));
%features