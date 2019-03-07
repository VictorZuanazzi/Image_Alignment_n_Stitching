function connect_KP(I1, I2, f1, f2, matches, num_matches)
% given two images, plot 10 random pairs of matching points.
%Input:
    %I1, I2, the two images 
    %f1, f2 are the sift coordinates (x, y, S, theta) descriptors from both images
    %matches: matrix with the indexes of the matching descriptors

[~, ~, selection] = select_matches(num_matches, matches);

fig = figure(1);
clf;

imshow([I1, I2]);

hold on;
x1 = f1(1,matches(1,selection)) ;
x2 = f2(1,matches(2,selection)) + size(I1,2) ;
y1 = f1(2,matches(1,selection)) ;
y2 = f2(2,matches(2,selection)) ;

h = line([x1 ; x2], [y1 ; y2]) ; 
set(h,'linewidth', 5, 'marker', 'o');
hold off;

%for perhaps future use:
%h1 = vl_plotframe(f1(:,f1_sel));
%h2 = vl_plotframe(f2(:,f2_sel));

end