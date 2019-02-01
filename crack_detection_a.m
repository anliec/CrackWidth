function [crack] = crack_detection_a(im,crack)

change_line = true;
change_column = true;

avg_im = imresize(im,1/32);
avg_im = avg_im .* 0.95;

while change_line | change_column
  [crack, change_line] = line_crack_update_a(im,crack,avg_im);
  [crack, change_column] = column_crack_update_a(im,crack,avg_im);
end

end
