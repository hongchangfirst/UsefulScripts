function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta


tmp = X*theta;
hx = sigmoid(tmp);
size(hx);
len = length(theta);

thetaSquare = theta(2:len).*theta(2:len);
regPart = (lambda / 2 / m) .* sum(thetaSquare);
J = -1 / m * sum(y.*log(hx) + (1-y).*log(1-hx)) + regPart;

% size = 28,1
grad = (1 / m .* sum((hx - y).*X))' .+ (lambda / m .* theta);
% override the first one, since we don't regularize the first parameter.
grad(1) = 1 / m .* sum(hx - y);

% =============================================================

end
