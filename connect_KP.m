function [KP_sample] = connect_KP(I1, I2, valid_points1, valid_points2, indexPairs)

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);
figure; 
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
end