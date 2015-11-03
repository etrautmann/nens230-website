function [Y,index] = Shuffle(X)
% [Y,index] = Shuffle(X)
%
% Randomly sorts X.
% If X is a vector, sorts all of X, so Y = X(index).
% If X is an m-by-n matrix, sorts each column of X, so
%	for j=1:n, Y(:,j)=X(index(:,j),j).
%
% Also see SORT, Sample, Randi, and RandSample.

[null,index] = sort(rand(size(X)));
[n,m] = size(X);
Y = zeros(size(X));
if (n == 1 | m == 1)
	Y = X(index);
else
	for j = 1:m
		Y(:,j)  = X(index(:,j),j);
	end
end
 