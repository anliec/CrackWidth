function [transform] = wavelettransform(im)

img=im2double(im);

% filters in JPEG2000
Lo_D=[0.0267 -0.0168 -0.0782 0.2668 0.6029 0.2668 -0.0782 -0.0168 0.0267];
Hi_D=[0.0912 -0.0575 -0.5912 1.1150 -0.5912 -0.0575 0.0912];

%calculate the 2-level Wavelet transform
[scaled, vertical, horizontal, diagonal]=dwt2(img,Lo_D,Hi_D);
[scaled2, vertical2, horizontal2, diagonal2]=dwt2(scaled,Lo_D,Hi_D);
[scaled3, vertical3, horizontal3, diagonal3]=dwt2(scaled2,Lo_D,Hi_D);

%crop pictures (for displaying purpose)
scaled3=imcrop(scaled3,[4 4 63 63]);
horizontal3=imcrop(horizontal3,[4 4 63 63]);
vertical3=imcrop(vertical3,[4 4 63 63]);
diagonal3=imcrop(diagonal3,[4 4 63 63]);
% scaled2=imcrop(scaled2,[4 4 127 127]);
horizontal2=imcrop(horizontal2,[4 4 127 127]);
vertical2=imcrop(vertical2,[4 4 127 127]);
diagonal2=imcrop(diagonal2,[4 4 127 127]);
horizontal=imcrop(horizontal,[4 4 255 255]);
vertical=imcrop(vertical,[4 4 255 255]);
diagonal=imcrop(diagonal,[4 4 255 255]);

%increase contrast (for displaying purpose)
vertical=imadjust(abs(vertical));
horizontal=imadjust(abs(horizontal));
diagonal=imadjust(abs(diagonal));
vertical2=imadjust(abs(vertical2));
horizontal2=imadjust(abs(horizontal2));
diagonal2=imadjust(abs(diagonal2));
vertical3=imadjust(abs(vertical3));
horizontal3=imadjust(abs(horizontal3));
diagonal3=imadjust(abs(diagonal3));


%put them all together
transform=zeros(512,512);

transform(1:64,1:64)=scaled3;
transform(1:64,65:128)=horizontal3;
transform(65:128,1:64)=vertical3;
transform(65:128,65:128)=diagonal3;
% transform(1:128,1:128)=scaled2;
transform(1:128,129:256)=horizontal2;
transform(129:256,1:128)=vertical2;
transform(129:256,129:256)=diagonal2;
transform(1:256,257:512)=horizontal;
transform(257:512,1:256)=vertical;
transform(257:512,257:512)=diagonal;

% imwrite(transform,'Jpeg2000_2-level_wavelet_transform-lichtenstein.png');

end
