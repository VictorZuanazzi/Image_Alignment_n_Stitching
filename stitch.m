function [I] = stitch(I1,I2)

% Set parameters.
inlier_threshold = 10;
num_trials = 5;
num_matches = 10; 

% Convert images to grayscale for keypoint matching
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% Find SIFT keypoints for both images and the matches between them.
[matches, k1, k2] = keypoint_matching(I2_gray, I1_gray);

% Find required rotation and translation.
[x, ~, ~] = RANSAC(inlier_threshold, num_trials, num_matches, I2_gray, I1_gray, k1, k2, matches, false);

[h, w, c] = size(I2)

tl = round(x * [1;1;1])
tr = round(x * [w;1;1])
bl = round(x * [1;h;1])
br = round(x * [w;h;1])


transform = affine2d(x');
default = imwarp(I2, transform);

I = zeros([800 800 3], 'like', I1);

[d_h, d_w, d_c] = size(default);

% shift transformed image
shifted = zeros([round(d_h + x(2,3)), round(d_w + x(1,3)), d_c], 'like', I1);
shifted(x(2,3):d_h+x(2,3)-1, x(1,3):d_w+x(1,3)-1,:) = default;

% create mask for tranformed image
mask = rgb2gray(shifted);
mask = mask ~= 0;
mask = cat(3,mask,mask,mask);

% copy I1 into result
[h,w,c] = size(I1);
I(1:h,1:w,1:c) = I1;

% blend images together with alpha mask
[h,w,c] = size(mask);
I(1:h,1:w,1:c) = I(1:h,1:w,1:c) .* cast(~mask, 'like', I);
[h,w,c] = size(shifted);
I(1:h,1:w,1:c) = I(1:h,1:w,1:c) + shifted .* cast(mask, 'like', I);

% I = imfuse(I1, shifted, 'blend');

figure(1);
imshow(I);