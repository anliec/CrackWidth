function [crack] = crack_detection(im,crack)

change_line = true;
change_column = true;

crack = (crack > 0) * 1.0;
gt_dist = 2;

im_mean = mean2(im);
im_std = std2(im);

while change_line || change_column
  [crack, change_line] = line_crack_update(im,crack,gt_dist,im_mean,im_std);
  [crack, change_column] = line_crack_update(im',crack',gt_dist,im_mean,im_std);
  crack = crack';
  gt_dist = gt_dist + 1;
end

% revert to the same format as ground truth
crack = (crack > 0) * 255;

end
