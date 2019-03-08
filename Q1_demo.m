% Close all previously opened figures.
close all;

% Read images.
I1 = imread('boat1.pgm');
I2 = imread('boat2.pgm');

% Set parameters.
inlier_threshold = 10;
num_trials = 5;
num_matches = 10; 

% Find SIFT keypoints for both images and the matches between them.
[matches, k1, k2] = keypoint_matching(I1, I2);

% Select random matching pairs.
selection = select_matches(num_matches, matches);

% Plot both images with lines between random matching pairs.
figure(1);
plot_pairs(I1, I2, k1(1:2,matches(1,selection)), k2(1:2,matches(2,selection)), 5);

% Find required rotation and translation.
[x, best_inlier] = RANSAC(inlier_threshold ,num_trials, num_matches, I1, I2, k1, k2, matches);
disp(best_inlier)

% Transform image 1 using imwarp.
figure(num_trials + 2);
transform = affine2d(x');
default = imwarp(I1, transform);
imshow(default);

% Transform image 1 using custom warp function.
figure(num_trials + 3);
custom = custom_warp(I1, x);
imshow(custom);