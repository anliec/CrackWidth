function [crack, change] = column_crack_update(im,crack)

[n,m] = size(im);

force_acept_speed = 60;
change = false;

for c = 1:n
  column = im(c,:);
  c_column = crack(c,:);
  pos = find(c_column == 255);
  old_pos = -1;
  for i = 1:length(pos)
    % if the previous value exist and wasn't already explored
    if pos(i) > 1 & crack(c,pos(i)-1) ~= 255
      % if we are not on the edge
      if pos(i) > 2
        % compute the acceleration
        v1 = column(pos(i)-1) - column(pos(i));
        v2 = column(pos(i)-2) - column(pos(i)-1);
        a = v2 - v1;
        % if acceleration and speed are positive we are on the good way
        if a >= 0 & v1 > 0 | v1 > force_acept_speed
          crack(c,pos(i)-1) = 255;
          change = true;
        end
      % if we cannot compute acceleration, we use speed
      elseif column(pos(i) - 1) > column(pos(i))
        crack(c,pos(i)-1) = 255;
        change = true;
      end
    end
    % if the next value exist and wasn't already explored
    if pos(i) + 1 <= m & crack(c,pos(i)+1) ~= 255
      % if we are not on the edge
      if pos(i) + 2 <= m
        % compute the acceleration
        v1 = column(pos(i)+1) - column(pos(i));
        v2 = column(pos(i)+2) - column(pos(i)+1);
        a = v2 - v1;
        % if acceleration and speed are positive we are on the good way
        if a >= 0 & v1 > 0 | v1 > force_acept_speed
          crack(c,pos(i)+1) = 255;
          change = true;
        end
      % if we cannot compute acceleration, we use speed
      elseif column(pos(i) + 1) > column(pos(i))
        crack(c,pos(i)+1) = 255;
        change = true;
      end
    end
    old_pos = pos(i);
  end
end

end
