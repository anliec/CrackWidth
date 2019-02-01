clear all;

high_freq_filter = 50; % percent value

% load sources files
im = imread('input images/0004.tiff');
gt = imread('ground truth/0004.tiff');

% apply low pass filter
[imf, ~] = lowpass(im, high_freq_filter);

% detect crack edge from ground truth
c = crack_detection(imf,gt);

% mesure the crack width using infinite norm for each point of the crack
cw = crack_width_detection(c);

% fit the crack width to the ground truth and recompute the width at the more
% important points using norm two
w = width_merge(cw,gt);

% create figures
high = max(cw(:));

figure(1);
subplot(1,3,1);
imshow(w,[0,high], 'ColorMap', jet);
title('Crack width fitted to ground truth');
colorbar;

subplot(1,3,2);
imshow(cw,[0,high], 'ColorMap', jet(high));
title('Crack width (basic mesure)');
colorbar;

subplot(1,3,3);
imshow(c,[0,255], 'ColorMap', jet(2));
title('Crack position');
colorbar;

figure(2)
subplot(1,2,1);
imshow(im);
title('Original image');
subplot(1,2,2);
imshow(gt);
title('Ground truth');

% this surface representation has position set for image 54, fell free to try other
% position for this or other images.
figure(3);
surf(imf(460:500,180:220), cw(460:500,180:220));
title(strcat('filtered image (',mat2str(high_freq_filter),'%)'));
