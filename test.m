
crack = gt;

change_line = true;
change_column = true;

figure(1);
while change_line | change_column
  [crack, change_line] = line_crack_update(im,crack);
  imshow(crack(810:870,150:210));
  pause(0.5);
  [crack, change_column] = column_crack_update(im,crack);
  imshow(crack(810:870,150:210));
  pause(0.5);
end
