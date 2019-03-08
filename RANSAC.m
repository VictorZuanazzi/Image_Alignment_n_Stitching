function [best_x, best_inlier] = RANSAC (inlier_threshold, num_trials, num_matches, I1, I2, k1, k2, matches)
% Find rotation and translation to transform between matching SIFT
% keypoints.
% Inputs: 
    % inlier_treshold: Maximum distance between transformed and target allowed for inliers
    % num_trials: Number of repeats for RANSAC (random match selections)
    % num_matches: Number of matches selected for each iteration.
    % k1, k2 are the SIFT keypoints (x, y, scale, orientation) from both
    % images.
    % matches: Matrix with the indexes of the matching keypoints.
% Outputs: 
    % best_x: Best transformation that was found (most inliers).
    % best_inlier: Number of inliers for the best transformation.

% Initialize outputs.
best_x = zeros(6,1);
best_inlier = -1;

% Main RANSAC loop.
for i = 1:num_trials
    % Select a random subset of matches.
    selection = select_matches(num_matches, matches);
    
    % Find corresponding keypoints for both images.
    k1_sel = k1(1:2, matches(1,selection)); 
    k2_sel = k2(1:2, matches(2,selection));
    
    % Find x and y coordinates for selected keypoints from image 1.
    x1 = k1_sel(1, :);
    y1 = k1_sel(2, :);
    
    % Find x and y coordinates for selected keypoints from image 2.
    x2 = k2_sel(1, :);
    y2 = k2_sel(2, :);
    
    % Create matrix A.
    A = [x1' y1' zeros(size(x1')) zeros(size(x1')) ones(size(x1')) zeros(size(x1')); 
        zeros(size(x1')) zeros(size(x1')) x1' y1' zeros(size(x1')) ones(size(x1'))];
    
    % Create vector b.
    b = [x2'; y2'];

    % Solve linear system.
    x = pinv(A)*b;
    
    % Turn transform parameters into a 3x3 affine transformation matrix.  
    x = [x(1) x(2) x(5); x(3) x(4) x(6); 0 0 1];

    % Show the two images side by side.
    figure(i+1);
    imshow([I1, I2]);

    % Plot the lines between matching keypoints.
    hold on;
    
    % Find all keypoints for image 1 and 2 that were matched.
    k1_matched = k1(1:2, matches(1, :));
    k2_matched = k2(1:2, matches(2, :));

    % x and y components of the matched keypoints in image 1.
    x1 = k1_matched(1,:);
    y1 = k1_matched(2,:);
    
    % Transform them to homogenous coordinates.
    k1_homogenous = [k1_matched; ones(1, size(k1_matched, 2))];
    
    % Transform matched keypoints. 
    k1_transformed = x*k1_homogenous;
    k1_transformed = k1_transformed(1:2,:);

    % x and y components of transformed matched keypoints (shifted to 2nd image)   
    x2 = k1_transformed(1,:) + + size(I1,2);
    y2 = k1_transformed(2,:);
    
    % Plot lines between original and transformed points.
    h = line([x1 ; x2], [y1 ; y2]) ; 
    set(h,'linewidth', 1, 'marker', 'o');
    hold off;
    
    % Count inliers.
    distance = vecnorm(k1_transformed  - k2_matched);
    inlier_c = sum(distance < inlier_threshold);
    
    % Check if this iteration was better than previous attempts.
    if inlier_c > best_inlier
        best_x = x;
        best_inlier = inlier_c;
    end
end

end