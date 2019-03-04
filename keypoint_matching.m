function [indexPairs, valid_points1, valid_points2] = keypoint_matching(I1, I2)
% Takes two imageages and return the keypoint matches between them.
% Inputs: I1, I2 are 2d images.
% Output: KP_match is a matrix containing the pixels coordinates(?) of the
% matching points.

%that is not what they wanted, I think
corners1 = detectFASTFeatures(I1, 'MinContrast', 0.3);
corners2 = detectFASTFeatures(I2, 'MinContrast', 0.3);
[features1,valid_points1] = extractFeatures(I1,corners1);
[features2,valid_points2] = extractFeatures(I2,corners2);
indexPairs = matchFeatures(features1,features2);

end