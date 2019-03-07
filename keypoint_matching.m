function [matches, f1, f2] = keypoint_matching(I1, I2)
% Takes two imageages and return the keypoint matches between them.
% Inputs: I1, I2 are 2d images.
% Output: 
    %matches: matrix 2 x n, containing the indexes of the matching features 
    % in two given figures.
    %f1, f2: matching features.
  
    %tutorial from vlfeat:
    %convert to single precision.
    I1 = single(I1);
    I2 = single(I2);

    %compute SIFT keypoints.
    [f1, d1] = vl_sift(I1);
    [f2, d2] = vl_sift(I2);
    [matches, scores] = vl_ubcmatch(d1, d2);

end