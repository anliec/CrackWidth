function [crack, change] = line_crack_update(im,crack,gt_dist, im_mean, im_std)

[n,m] = size(im);

force_acept_speed = 20;
change = false;

for l = 1:m
  line = im(:,l);
  c_line = crack(:,l);
  pos = find(c_line >= gt_dist - 1);
  for i = 1:length(pos)
    % if the previous value exist and wasn't already explored
    if (pos(i) > 1) && (crack(pos(i)-1,l) == 0) && (pos(i) + 1 <= n)
      % if we are not on the edge
      if pos(i) > 3
        % compute the acceleration
        v0 = line(pos(i)) - line(pos(i)+1);
        v1 = line(pos(i)-1) - line(pos(i));
        v2 = line(pos(i)-2) - line(pos(i)-1);
        a1 = (v2 - v1) / (abs(v1) + 0.0001); % add 0.0001 to prevent division by 0
        a0 = (v1 - v0) / (abs(v1) + 0.0001); % add 0.0001 to prevent division by 0
        if (line(pos(i)-1) < im_mean-3*im_std) || ((a0 >= -0.2 || a1 >= 0.1) && v1 > 0 && v2 > 0) || ((gt_dist < 6 && (v1+v2) >= 0 && v1 <= 0 && v0 < 0)) || (gt_dist < 6 && v0 < 0 && v1 < 0)
          crack(pos(i)-1,l) = gt_dist;
          change = true;
        end
      % if we cannot compute acceleration, we use speed
      elseif line(pos(i) - 1) > line(pos(i))
        crack(pos(i)-1,l) = gt_dist;
        change = true;
      end
    end
    % if the next value exist and wasn't already explored
    if (pos(i) + 1 <= n) && (crack(pos(i)+1,l) == 0) && (pos(i) > 1)
      % if we are not on the edge
      if pos(i) + 3 <= n
        % compute the acceleration
        v0 = line(pos(i)) - line(pos(i)-1);
        v1 = line(pos(i)+1) - line(pos(i));
        v2 = line(pos(i)+2) - line(pos(i)+1);
        a1 = (v2 - v1) / (abs(v1) + 0.0001); % add 0.0001 to prevent division by 0
        a0 = (v1 - v0) / (abs(v1) + 0.0001); % add 0.0001 to prevent division by 0
        if (line(pos(i)-1) < im_mean-3*im_std) || ((a0 >= -0.2 || a1 >= 0.1) && v1 > 0 && v2 > 0) || (gt_dist < 6 && (v1+v2) >= 0 && v1 <= 0 && v0 < 0) || (gt_dist < 6 && v0 < 0 && v1 < 0)
          crack(pos(i)+1,l) = gt_dist;
          change = true;
        end
      % if we cannot compute acceleration, we use speed
      elseif line(pos(i) + 1) > line(pos(i))
        crack(pos(i)+1,l) = gt_dist;
        change = true;
      end
    end
    old_pos = pos(i);
  end
end

end
