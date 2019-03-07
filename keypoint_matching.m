function [matches] = keypoint_matching(I1, I2, method)
% Takes two imageages and return the keypoint matches between them.
% Inputs: I1, I2 are 2d images.
% Output: matches is a matrix containing the pixels coordinates(?) of the
% matching points. Shouldn't we also return the descriptors?

switch lower(method)
    case 'matlab'
        %that is not what they wanted, I think
        corners1 = detectFASTFeatures(I1, 'MinContrast', 0.3);
        corners2 = detectFASTFeatures(I2, 'MinContrast', 0.3);
        [features1,valid_points1] = extractFeatures(I1,corners1);
        [features2,valid_points2] = extractFeatures(I2,corners2);
        matches = matchFeatures(features1,features2);
    
    case 'vl'
        %tutorial from vlfeat:
        %convert to single precision.
        I1 = single(I1);
        I2 = single(I2);

        %compute SIFT keypoints.
        [f1, d1] = vl_sift(I1);
        [f2, d2] = vl_sift(I2);
        [matches, scores] = vl_ubcmatch(d1, d2);
end



end