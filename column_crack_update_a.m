function [crack, change] = column_crack_update_a(im,crack,avg_im)

[n,m] = size(im);

change = false;

for c = 1:n
  column = im(c,:);
  c_column = crack(c,:);
  pos = find(c_column == 255);
  old_pos = -1;
  for i = 1:length(pos)
    if pos(i) ~= old_pos + 1
      if (pos(i) > 1 & column(pos(i) - 1) < avg_im(ceil(pos(i) / 32)))
        crack(c,pos(i)-1) = 255;
        change = true;
      end
    end
    if i < length(pos) & pos(i) + 1 ~= pos(i + 1)
      if (pos(i) < m & column(pos(i) + 1) < avg_im(ceil(pos(i) / 32)))
        crack(c,pos(i)+1) = 255;
        change = true;
      end
    end
    old_pos = pos(i);
  end
end

end
