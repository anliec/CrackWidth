function [w] = width_detection_n2(x,y,crack,exploration_width)

r = ceil(exploration_width / 2);
[n,m] = size(crack);

x_min = max([1, x-r]);
x_max = min([n, x+r]);
y_min = max([1, y-r]);
y_max = min([m, y+r]);
exploration_zone = crack(x_min:x_max,y_min:y_max);

xi = -r:r;
yi = xi';
dist_coef_matrix = sqrt(xi.^2 + yi.^2);

% we are on edge we need to crop dist_coef_matrix
x_min = max([1, 2+r-x]);
x_max = min([2*r+1, r+1+n-x]);
y_min = max([1, 2+r-y]);
y_max = min([2*r+1, r+1+m-y]);
dist_coef_matrix = dist_coef_matrix(x_min:x_max,y_min:y_max);

dist_matrix = (exploration_zone == 0) .* dist_coef_matrix;
% set a very big value to replace 0 to use min later
dist_matrix(find(dist_matrix == 0)) = 1000;


[k,l] = size(dist_matrix);

% divide the space into four quarter to limit the chance to pick two times
% a value from the same side
quarter1 = dist_matrix(1:floor(k/2),   1:floor(l/2)+1);
quarter2 = dist_matrix(floor(k/2)+1:k, 1:floor(l/2));
quarter3 = dist_matrix(floor(k/2):k,   floor(l/2)+1:l);
quarter4 = dist_matrix(1:floor(k/2)+1, floor(l/2):l);

% get the min distance for each quarter
quarter_min_values = zeros(4,1);
quarter_min_values(1) = min(quarter1(:));
quarter_min_values(2) = min(quarter2(:));
quarter_min_values(3) = min(quarter3(:));
quarter_min_values(4) = min(quarter4(:));

% try to get the width by using diagonal value
w = min([quarter_min_values(1) + quarter_min_values(3), quarter_min_values(2) + quarter_min_values(4)]);

if w > 1000
  % if this was not the correct way to get the width use more resilient methods

  quarter_min_values = sort(quarter_min_values);

  if quarter_min_values(1) == 1000
    % no value found, return the exploration radius
    w = r;
    warning('width_detection_n2 did not found the width');
  elseif quarter_min_values(2) == 1000
    % only one quarter as a correct quarter return two time this value
    w = quarter_min_values(1) * 2;
  elseif quarter_min_values(2) > min([y, m-y, x, n-x])
    % if one of the smallest value is bigger than the distance to a edge of the image
    % replace a value by the distance to that edge
    w = quarter_min_values(1) + min([y, m-y, x, n-x]);
  else
    % the end width is the sum of the two min distance
    w = quarter_min_values(1) + quarter_min_values(2);
  end

end


end
