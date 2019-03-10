function [stiched_image] = stitch(I1,I2)

% Set parameters.
inlier_threshold = 10;
num_trials = 5;
num_matches = 10; 

stiched_image = [];

I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% Find SIFT keypoints for both images and the matches between them.
[matches, k1, k2] = keypoint_matching(I2_gray, I1_gray);

% Find required rotation and translation.
[x, best_inlier, required_trials] = RANSAC(inlier_threshold, num_trials, num_matches, I2_gray, I1_gray, k1, k2, matches, false);


figure(1);
imshow(I1);

figure(2);
transform = affine2d(x');
default = imwarp(I2, transform);
imshow(default);