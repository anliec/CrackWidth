function [transform] = wavelettransform2(im, order)

img=im2double(im);

[m,n]=size(im);

transform = im;

for o = 1:order
  src = transform(1:m/o, 1:n/o);
  [scaled, vertical, horizontal, diagonal]=dwt2(src,'haar');
  scaled = normalize_image(scaled);
  vertical = normalize_image(vertical);
  horizontal = normalize_image(horizontal);
  diagonal = normalize_image(diagonal);
  mt = m / (o + 1);
  nt = n / (o + 1);
  transform(1:mt, 1:nt) = scaled(:,:);
  transform(mt+1:2*mt, 1:nt) = vertical(:,:);
  transform(1:mt, nt+1:2*nt) = horizontal(:,:);
  transform(mt+1:2*mt,nt+1:2*nt) = diagonal(:,:);
end

end

function [in] = normalize_image(i)
  in = i - min(i(:));
  in = in * 255 / max(in(:));
end
