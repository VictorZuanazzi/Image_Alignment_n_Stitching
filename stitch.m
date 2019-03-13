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

% Transform corners of image 2
[h1,w1,~] = size(I1);
[h2,w2,~] = size(I2);
tl = x * [1;1;1];
tr = x * [w2;1;1];
bl = x * [1;h2;1];
br = x * [w2;h2;1];

min_x = floor(min([tr(1),tl(1),bl(1),br(1)]));
max_x = ceil(max([tr(1),tl(1),bl(1),br(1)]));
width = max(max_x,w1) - min(min_x,1) + 1;

min_y = floor(min([tr(2),tl(2),bl(2),br(2)]));
max_y = ceil(max([tr(2),tl(2),bl(2),br(2)]));
height = max(max_y,h1) - min(min_y,1) + 1;

%transform = affine2d(x');
%warped = imwarp(I2, transform);
warped = custom_warp(I2, x);

I = zeros([height width 3], 'like', I1);

% shift transformed image
[h,w,c] = size(warped);
shifted = zeros([height, width, c], 'like', I1);
shifted(min_y:h+min_y-1, min_x:w+min_x-1,:) = warped;

imwrite(shifted,'right_extended.png');

% create mask for tranformed image
mask = rgb2gray(shifted);
mask = mask ~= 0;
mask = cat(3,mask,mask,mask);

% copy I1 into result
[h,w,c] = size(I1);
I(1:h,1:w,1:c) = I1;

imwrite(I,'left_extended.png');

% blend images together with alpha mask
[h,w,c] = size(mask);
I(1:h,1:w,1:c) = I(1:h,1:w,1:c) .* cast(~mask, 'like', I);
[h,w,c] = size(shifted);
I(1:h,1:w,1:c) = I(1:h,1:w,1:c) + shifted .* cast(mask, 'like', I);
end