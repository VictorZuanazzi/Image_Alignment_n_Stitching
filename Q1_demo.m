% Close all previously opened figures.
close all;

% Read images.
I1 = imread('boat1.pgm');
I2 = imread('boat2.pgm');

% Find SIFT keypoints for both images and the matches between them.
[matches, k1, k2] = keypoint_matching(I1, I2);

% Plot both images with lines between 10 random matching pairs.
num_matches = 10; 
figure(1);
connect_KP(I1, I2, k1, k2, matches, num_matches);

% Find required rotation and translation.
inlier_threshold = 10;
num_trials = 5;
[x, best_inlier] = RANSAC(inlier_threshold ,num_trials, num_matches, I1, I2, k1, k2, matches);
disp(best_inlier)

% Transform image 1 using imwarp.
figure(num_trials + 2);
transform = affine2d(x');
I1to2 = imwarp(I1, transform);
imshow(I2to1);

% Transform image 1 using custom warp function.
figure(num_trials + 3);
I1to2_bad = bad_warp(I1, x);
imshow(I1to2_bad);