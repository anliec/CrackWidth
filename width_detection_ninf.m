function [w] = width_detection_ninf(linpos,crack)

[n,m] = size(crack);
y = floor((linpos-1)/n) + 1;
x = mod((linpos-1), n) + 1;
w = 0;

while true
  x_min = max([1, x-w]);
  x_max = min([n, x+w]);
  y_min = max([1, y-w]);
  y_max = min([m, y+w]);
  if min(min(crack(x_min:x_max,y_min:y_max))) == 0
    break;
  end
  w = w + 1;
end

w = 2 * w - 1;

end
