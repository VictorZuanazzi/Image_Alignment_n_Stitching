% figure(1);
% imshow('left.jpg');
% 
% figure(2);
% imshow('right.jpg');


% figure(3);
% imshow('boat1.pgm');
% 
% figure(4);
% imshow('boat2.pgm');


A=imread('left.jpg');
size(A)
figure()
A(1:1) = 0; 
imshow(A)


