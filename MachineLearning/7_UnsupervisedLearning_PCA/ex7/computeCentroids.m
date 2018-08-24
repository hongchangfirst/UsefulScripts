function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

for i = 1:K
	all = zeros(1, n);
	count = 1;
	for j = 1:m
		group = idx(j);
		if group == i
			addi = X(j,:) - all(1,:);
			all(1,:) += addi ./ count;
			count += 1;
		end
	end
	centroids(i,:) = all(1,:);
end

% second solution using find function.
%for i = 1:K
%	% list is all the index that belongs to group i.
%	list = find(idx == i);
%	listLen = length(list);
%	for j = 1:listLen
%		group = list(j);
%		centroids(i,:) = centroids(i,:) + X(group,:);
%	end
%	centroids(i,:) = centroids(i,:) ./ listLen;
%end




% =============================================================


end

