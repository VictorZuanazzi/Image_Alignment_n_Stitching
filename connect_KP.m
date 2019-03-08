function connect_KP(I1, I2, f1, f2, matches, num_matches)
% Given two images, plot a given number of random pairs of matching points.
%Inputs:
    % I1, I2, the two images. 
    % f1, f2 are the SIFT keypoints (x, y, scale, orientation) from both
    % images.
    % matches: Matrix with the indexes of the matching keypoints.
    % num_matches: The desired number of pairs.

% Select a random subset of matches.
selection = select_matches(num_matches, matches);

% Show the two images side by side.
imshow([I1, I2]);

% Plot the lines between matching keypoints.
hold on;
x1 = f1(1,matches(1,selection)) ;
x2 = f2(1,matches(2,selection)) + size(I1,2) ;
y1 = f1(2,matches(1,selection)) ;
y2 = f2(2,matches(2,selection)) ;
h = line([x1 ; x2], [y1 ; y2]) ; 
set(h,'linewidth', 5, 'marker', 'o');
hold off;

end