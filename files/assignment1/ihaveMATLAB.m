% This is a comment. It is notes for humans, by humans. The computer will not read this...
% or so it wants us to think?!

X = rand(50,50,3).*0.3;
figh = figure; image(X); axis off;
th = text(0.05,.5,{'You Have MATLAB!','Save this as a .fig and email it to nens230@gmail.com'}, 'Units', 'normalized', ...
     'Color', 'w', 'FontSize', 16);
set( figh, 'UserData', sprintf('Generated at %s %s %s', ...
 datestr( now ), version, computer) );