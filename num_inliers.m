function [inlier_c] = num_inliers(threshold, f1_sel, f2_sel, x)

x = reshape(x, [2, 3]);
x = [x ; 0 0 1];

f1_sel = [f1_sel; ones(1, size(f1_sel, 2))];
f1_rot = x*f1_sel;
f1_rot = f1_rot(1:2,:);

distance = vecnorm(f1_rot - f2_sel);

inlier_c = sum(distance < threshold);
end