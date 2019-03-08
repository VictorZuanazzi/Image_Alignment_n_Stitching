function [I_transform] = bad_warp (I, transform)
% our own inplementation of imwrap
% input: 
    %I : image in grayscale to be transformed.
    %transform: 3x3 rotation and translation matrix.
%Output:
    %I_transform: Tranformed version of I.

%find end image size.
x_min = Inf;
x_max = -Inf;
y_min = Inf;
y_max = -Inf;
[width, heigth] = size(I);
corners = [0 0 1; 0 heigth 1; width 0 1; width heigth 1];
for i = 1:4
    corner = corners(i, :)';
    rotated_corner = transform\corner;
    x = rotated_corner(1);
    y = rotated_corner(2);
    if x > x_max
        x_max = x;
    end
    if x < x_min
        x_min = x;
    end
    if y > y_max
        y_max = y;
    end
    if y < y_min
        y_min = y;
    end
end

width_rot = ceil(x_max - x_min);
heigth_rot = ceil(y_max - y_min);

I_transform = zeros(width_rot, heigth_rot, 'uint8');

% Transform I into I_transform.
for i = 1:width_rot
    for j = 1:heigth_rot
        homogenous = [i + x_min, j + y_min, 1]';
        rotated = transform * homogenous;
        if (rotated(1) >= 1) && (rotated(1) <= width) && (rotated(2) >= 1) && (rotated(2) <= heigth)
            I_transform(i,j) = I(round(rotated(1)), round(rotated(2)));
        end
    end
end

end