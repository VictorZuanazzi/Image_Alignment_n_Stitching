function plot_pairs(I1, I2, k1_sel, k2_sel, linewidth)
% Given two images, plot lines between the given pairs of keypoints.
%Inputs:
    % I1, I2, the two images. 
    % k1_sel, k2_sel are the x/y coordinates of the given keypoints in both images.

% Show the two images side by side.
imshow([I1, I2]);
hold on;

% Plot the lines between matching keypoints.
x1 = k1_sel(1,:);
x2 = k2_sel(1,:) + size(I1,2) ;
y1 = k1_sel(2,:);
y2 = k2_sel(2,:);
h = line([x1 ; x2], [y1 ; y2]) ; 
set(h,'linewidth', linewidth, 'marker', 'o');
hold off;

end