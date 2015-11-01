char = '+';
feature = 3;

hold on;
for i= 1:1:15
    load(sprintf('training_data/features_%s_%.2d', char, i), 'features')
    figure1 = features;
    plot(features(feature, :))
end
ylabel('Feature value')
xlabel('Feature id')