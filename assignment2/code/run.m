maxtime = 5;
figure = DrawCharacter(maxtime);

features = FeatureExtractor(figure);

plot(transpose(features));
features