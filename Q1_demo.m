I1 = imread('boat1.pgm');
I2 = imread('boat2.pgm');

[matches, f1, f2] = keypoint_matching(I1, I2);

num_matches = 10;
connect_KP(I1, I2, f1, f2, matches, num_matches);

inlier_threshold = 10;
num_trials = 10;
best_x = RANSAC (inlier_threshold ,num_trials, num_matches, f1, f2, matches);

x = reshape(best_x, [2,3]);
x = [x; 0 0 1];
x_inv = inv(x);
transform = affine2d(x');
Iresult = imwarp(I2, transform);
figure(2);
imshow(Iresult);

figure(4);
transform_inv = affine2d(x_inv');
I_inv = imwarp(I1, transform_inv);
imshow(I_inv);

figure(3);
imshow([I1, I2]);


