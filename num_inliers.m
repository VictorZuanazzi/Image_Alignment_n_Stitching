function [inlier_c] = num_inliers(threshold, f1_sel, f2_sel, x)

x = reshape(x, [2, 3]);
x = [x ; 0 0 1];
% disp(x)
f2_sel = [f2_sel; ones(1, size(f2_sel, 2))];
f2_rot = x*f2_sel;
f2_rot = f2_rot(1:2,:);
% disp(f1_sel)
% disp(f2_rot)
% disp(f2_sel)
distance = vecnorm(f2_rot - f1_sel);
% disp(distance)

inlier_c = sum(distance < threshold);
end