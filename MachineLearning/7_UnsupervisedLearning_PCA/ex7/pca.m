function [U, S] = pca(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
% X is 50 by 2.
[m, n] = size(X);

% You need to return the following variables correctly.
% U is n by n squared matrix, 2 by 2.
U = zeros(n);
S = zeros(n);

% ====================== YOUR CODE HERE ======================
% Instructions: You should first compute the covariance matrix. Then, you
%               should use the "svd" function to compute the eigenvectors
%               and eigenvalues of the covariance matrix. 
%
% Note: When computing the covariance matrix, remember to divide by m (the
%       number of examples).
%
% 
% X is 50 by 2.


% Sigma is 2 by 2.
% U is 2 by 2. Each row represents the original features/dimensionalities. Each column represents the weight.
% S is 2 by 2.
% V is 2 by 2.
Sigma = 1 / m .* (X'*X);
[U,S,V] = svd(Sigma);
U;
S;
V;
size(V);






% =========================================================================

end
