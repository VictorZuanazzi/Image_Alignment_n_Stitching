%close all images from the previous run.
close all;

%calls the library that does the magic.
vl_setup;

%read images
I1 = imread('boat1.pgm');
I2 = imread('boat2.pgm');

%get the coordinates of the descriptors and a matrix that matches them.
[matches, f1, f2] = keypoint_matching(I1, I2);

%plot the two images showing the descriptors.
num_matches = 10; %size(matches, 1); %10;
connect_KP(I1, I2, f1, f2, matches, num_matches);

%find the best - or just a good one - rotation matrix.
inlier_threshold = 10;
num_trials = 100;
num_experiments = 10;
first_good = zeros(num_experiments,1);

best_inlier = -1;
for i = 1:num_experiments
    [b_x, best_in, first_good(i)] = RANSAC(inlier_threshold ,num_trials, num_matches, f1, f2, matches);
    if best_in > best_inlier
        best_inlier = best_in;
        best_x = b_x;
    end
end

figure(42)
histogram(first_good)
%reshape best_x to the rotation matrix
x = reshape(best_x, [2,3]);
x = [x; 0 0 1];

%display and save results:
transform = affine2d(x');
I2to1 = imwarp(I2, transform);
I2to1_bad = bad_warp(I2, x);
figure(2);
imshow(I2to1);
figure(3);
imshow(I2to1_bad);

x_inv = inv(x);
transform_inv = affine2d(x_inv');
I1to2 = imwarp(I1, transform_inv);
I1to2_bad = bad_warp(I1, x_inv);
figure(4);
imshow(I1to2);
figure(5);
imshow(I1to2_bad);

figure(6);
imshow([I1, I2]);


