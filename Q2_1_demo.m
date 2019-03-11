I1 = imread('left.jpg');
I2 = imread('right.jpg');

I_stitch = stitch(I1,I2);

figure;
imshow(I_stitch);

imwrite(I_stitch,'stitching.png');


