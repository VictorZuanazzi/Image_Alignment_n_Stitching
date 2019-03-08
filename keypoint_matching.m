function [matches, k1, k2] = keypoint_matching(I1, I2)
% Takes two images and returns the SIFT keypoint matches between them.
% Inputs: I1, I2 are 2d images.
% Outputs: 
    % matches: matrix 2 x n, containing the indexes of the matching
    % keypoints in two given figures.
    % k1, k2: SIFT keypoints for both images.
  
    % Tutorial from vlfeat:
    % Convert to single precision.
    I1 = single(I1);
    I2 = single(I2);

    % Find SIFT keypoints and descriptors for both images.
    [k1, d1] = vl_sift(I1);
    [k2, d2] = vl_sift(I2);
    
    % Find matches between descriptors from both images.
    [matches, ~] = vl_ubcmatch(d1, d2);  
end