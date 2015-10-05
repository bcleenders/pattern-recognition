% Returns a vector of featurevectors.
% Each featurevector has:
% startX
% startY
% endX
% endY
% direction
% maxdistance (detect circles)

function lines = FeatureExtractor(maxtime)

figure = DrawCharacter(maxtime);

% Count the number of lines
% Lines are separated by one or more zeroes (third row)
numLines = 0;
lastZero = true;
minX = 0;
minY = 0;
maxX = 0.0000001; % No divide by zero error
maxY = 0.0000001; % No divide by zero error
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
    end
end

% moved = figure ;

% The factor we are going to scale with in x and y direction
xscale = 1/((maxX - minX) + 0.00001);
yscale = 1/((maxY - minY) + 0.00001);

scaled = (figure- repmat([minX; minY; 0], 1, length(figure))).*repmat([xscale; yscale; 1], 1, length(figure));

% Clear some stuff from memory
clear figure;
% clear moved;

% At this point, scaled has columns with three elements
% For each element with e(3)==0, it holds that 0 <= e(1), e(2) <= 1

lastZero = true;
lines = zeros(6, numLines);
j = 0;
linestart = 0;

for i = 1:length(scaled)
    if (lastZero && scaled(3, i) == 1)
        j = j+1;
        linestart = i;
        
        lines(1, j) = scaled(1, i);
        lines(2, j) = scaled(2, i);
        
        lastZero = false;
    end
    % If the user release the mouse (this one is zero and the next one is
    if ((scaled(3, i) == 0 && ~lastZero) || (scaled(3, i) == 1 && i == length(scaled)))
       lastZero = true;
       lines(3, j) = scaled(1, i);
       lines(4, j) = scaled(2, i);
       
       % The direction (in radians)
       % -pi <= atan2(Y,X) <= pi
       % atan2(0, 1) = 0        (right)
       % atan2(1, 0) = 1/2 pi   (up)
       % atan2(0, -1)= pi       (left)
       % atan2(-1, 0)= -1/2 pi  (down)
       lines(4,j)
       lines(2,j)
       lines(3,j)
       lines(1,j)
       lines(5, j) = atan2(lines(4, j) - lines(2, j) + 0.00001, lines(3, j) - lines(1, j) + 0.00001);
       
       
       % Source:
       % http://stackoverflow.com/questions/25800286/how-to-get-the-point-to-line-segment-distance-in-2d
       maxd = 0;
       v1 = [lines(1, j) lines(2, j) 0];
       v2 = [lines(3, j) lines(4, j) 0];
       for ii = linestart:i
        pt = [scaled(1, ii) scaled(2, ii) 0];
        a = v1 - v2;
        b = pt - v2;
        d = norm(cross(a,b)) / norm(a);
        
        maxd = max(maxd, d);
       end
       lines(6, j) = maxd;
    end
end