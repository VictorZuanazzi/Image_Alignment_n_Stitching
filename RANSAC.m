function [best_x, best_inlier] = RANSAC (inlier_threshold ,num_trials, num_matches, f1, f2, matches)

best_x = zeros(6,1);
best_inlier = -1;
for i = 1:num_trials
    [f1_idx, f2_idx, ~] = select_matches(num_matches, matches);
    x1 = f1(1, f1_idx);
    y1 = f1(2, f1_idx);

    A = [x1' y1' zeros(size(x1')) zeros(size(x1')) ones(size(x1')) zeros(size(x1')); 
        zeros(size(x1')) zeros(size(x1')) x1' y1' zeros(size(x1')) ones(size(x1'))];

    x2 = f2(1, f2_idx);
    y2 = f2(2, f2_idx);

    b = [x2'; y2'];

    x = pinv(A)*b;
    f1_sel = f1(1:2, f1_idx);
    f2_sel = f2(1:2, f2_idx);
    inlier_c = num_inliers(inlier_threshold, f1_sel, f2_sel, x);
    
    if inlier_c > best_inlier
        best_x = x;
        best_inlier = inlier_c;
    end
    
end

end