function [c, change] = line_crack_update(im,c,avg_im)

[n,m] = size(im);

change = false;

for l = 1:m
  line = im(:,l);
  c_line = c(:,l);
  pos = find(c_line == 255);
  old_pos = -1;
  for i = 1:length(pos)
    if pos(i) ~= old_pos + 1
      if (pos(i) > 1 & line(pos(i) - 1) < avg_im(ceil(pos(i) / 32)))
        c(pos(i)-1,l) = 255;
        change = true;
      end
    end
    if i < length(pos) & pos(i) + 1 ~= pos(i + 1)
      if (pos(i) < m & line(pos(i) + 1) < avg_im(ceil(pos(i) / 32)))
        c(pos(i)+1,l) = 255;
        change = true;
      end
    end
    old_pos = pos(i);
  end
end

end
