function [crack_widht] = crack_width_detection(crack)

[n,m] = size(crack);
crack_widht = zeros(n,m);

linpos = find(crack == 255);

for i = 1:length(linpos)
  crack_widht(linpos(i)) = width_detection_ninf(linpos(i), crack);
end

%find square and increment it as the square center is probably in the center of the crack
crack_o = crack_widht(1:n-1,1:m-1);
crack_v = crack_widht(1:n-1,2:m);
crack_h = crack_widht(2:n,1:m-1);
crack_d = crack_widht(2:n,2:m);

square_matrix = (crack_o ~= 0) & (crack_o == crack_v) & (crack_o == crack_d) & (crack_o == crack_h);

square_linpos = find(square_matrix);
%switch to x/y coordinate to correct the size difference
y = floor((square_linpos-1)/(n-1));
x = mod((square_linpos-1), (n-1)) + 1;
% correct linear position using x/y
square_linpos = y .* n + x;

% increment found square orgine (not the whole square to prevent multiple incrementation)
crack_widht(square_linpos) = crack_widht(square_linpos) + 1;

end  % function
