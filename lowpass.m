function [low_image, high_image] = lowpass(im,f,normalize)
%LOWPASS Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
  normalize = false;
end

[m,n]=size(im);

h_fft = zeros(m,n);

% FFT
im_fft = fft2(im);

fx = floor(m * f / 200);
fy = floor(n * f / 200);

h_fft( (m/2+1) + (-fx:fx) , : ) = im_fft( (m/2+1) + (-fx:fx) , : );
h_fft( : , (n/2+1) + (-fy:fy) ) = im_fft( : , (n/2+1) + (-fy:fy) );
%zero out a symmetric region of frequencies
im_fft( (m/2+1) + (-fx:fx) , : ) = 0;
im_fft( : , (n/2+1) + (-fy:fy) ) = 0;

% inverse FFT
low_image = abs(ifft2(im_fft));
high_image = abs(ifft2(h_fft));

if normalize
  low_image = low_image - min(low_image(:));
  high_image = high_image - min(high_image(:));
  low_image = low_image ./ max(low_image(:));
  high_image = high_image ./ max(high_image(:));
end

end
