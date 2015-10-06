% Returns a vector of featurevectors.
% Each featurevector has:
% position (X and Y coordinates)
% number of lines drawn so far
% direction from last point

function features = FeatureExtractor(maxtime)

figure = DrawCharacter(maxtime);

% Count the number of lines
% Lines are separated by one or more zeroes (third row)
lastZero = true;
numLines = 0;
numNotZero = 0;

% Set initial values for min/max values
minX = figure(1, 1);
minY = figure(2, 1);
maxX = minX;
maxY = minY;

for i = 1:length(figure)
    if (lastZero && figure(3, i) == 1)
        numLines = numLines +1;
        lastZero = false;
    end
    if (figure(3, i) == 0)
       lastZero = true; 
    end
    if(figure(3, i) == 1)
       minX = min(figure(1, i), minX);
       minY = min(figure(2, i), minY);
       maxX = max(figure(1, i), maxX);
       maxY = max(figure(2, i), maxY);
       
       % Keep score how many non-null values we've encountered
       numNotZero = numNotZero + 1;
       
       % Set how many lines we've had so far
       figure(4, i) = numLines;
    end
end

% Scale by the smallest factor (so that it fits in the unit square but is
% not stretched
scale = 1 / max([(maxX-minX) (maxY - minY) 0.1]);
% Apply offset and scale to figure
scaled = (figure- repmat([minX; minY; 0; 0], 1, length(figure))).*repmat([scale; scale; 1; 1], 1, length(figure));

% Clear some stuff from memory
clear figure;

% At this point, scaled has columns with three elements
% For each element with e(3)==1, it holds that 0 <= e(1), e(2) <= 1

% Number of measurements with mouse pressed
j = 0;

% Output
features = zeros(3, numNotZero);

for i = 2:length(scaled)
    if(scaled(3, i) == 1)
       j = j+1;
       % Scaled x coordinate
       features(1, j) = scaled(1, i);
       % Scaled y coordinate
       features(2, j) = scaled(2, i);
       % Number of lines drawn so far
       features(3, j) = scaled(4, i);
       
       % Direction between current and previous point
       % The direction (in radians)
       % -pi <= atan2(Y,X) <= pi
       % atan2(0, 1) = 0        (right)
       % atan2(1, 0) = 1/2 pi   (up)
       % atan2(0, -1)= pi       (left)
       % atan2(-1, 0)= -1/2 pi  (down)
       features(4, j) = atan2(scaled(2, i) - scaled(2, i-1) + 0.00001, scaled(1, i) - scaled(1, i-1) + 0.00001);
    end
end