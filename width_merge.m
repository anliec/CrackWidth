function [gt_width] = width_merge(width, gt)

w = 3; % merged value is the max value into a w*2+1 side squar centered on current value

[n,m] = size(gt);
gt_width = zeros(n,m);

linpos = find(gt ~= 0);

for i = 1:length(linpos)
  x = mod((linpos(i)-1), n) + 1;
  y = floor((linpos(i)-1)/n) + 1;

  x_min = max([1, x-w]);
  x_max = min([n, x+w]);
  y_min = max([1, y-w]);
  y_max = min([m, y+w]);
  shearch_zone = width(x_min:x_max,y_min:y_max);
  [max_val,max_pos_lin]  = max(shearch_zone(:));

  max_pos_x = x_min + mod((max_pos_lin-1), x_max-x_min+1);
  max_pos_y = y_min + floor((max_pos_lin-1)/(x_max-x_min+1));

  gt_width(linpos(i)) = width_detection_n2(max_pos_x, max_pos_y, width, ceil(max_val * 1.4142));
end

end
