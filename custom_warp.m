function [I_transform] = custom_warp (I, transform)
% Our own inplementation of imwarp.
% Inputs: 
    %I : Image in grayscale to be transformed.
    %transform: 3x3 affine transformation matrix.
% Outputs:
    %I_transform: Tranformed version of I.

% Rotate the 4 corners to find the required size of the new image.
x_min = Inf;
x_max = -Inf;
y_min = Inf;
y_max = -Inf;
[width, heigth, channels] = size(I);
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

% Create new image.
I_transform = zeros(width_rot, heigth_rot, channels, 'uint8');

% For every pixel in the new image, transform it back to the original image
% space and read the closest color (black if the transformed point lies
% outside the original image). This method ensures that every pixel in the
% new image will have a color, but it can cause duplicate pixels. 
for i = 1:width_rot
    for j = 1:heigth_rot
        homogenous = [i + x_min, j + y_min, 1]';
        rotated = transform * homogenous;
        if (rotated(1) >= 1) && (rotated(1) <= width) && (rotated(2) >= 1) && (rotated(2) <= heigth)
            for c = 1:channels
                I_transform(i,j, c) = I(round(rotated(1)), round(rotated(2)), c);
            end
        end
    end
end

end