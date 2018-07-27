function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a three layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables, training examples.
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% hidden_layer_size = 25, input_layer_siez = 400,
% X is 5000 by 400, so add bias unit.
X = [ones(m,1) X];

% 5000 by 401
%size(X)
% 25 by 401
%size(Theta1)

% second layer
A1 = sigmoid(X*Theta1');

% A1 is 5000 by 25, so add bias unit
A1 = [ones(m,1) A1];

% 5000 by 26
% size(A1)

% 10 by 26
size(Theta2);

A2 = sigmoid(A1*Theta2');

% 5000 by 10
size(A2);

class = [1:num_labels];
for i = 1:m,
	yy(i,:) = (class == y(i));
end

% 5000*10
size(yy);

total = yy.*log(A2) + (1 - yy).*log(1-A2);
% 5000 by 10
size(total);

totalError = sum(total,2);
% 5000 by 1
size(totalError);

% we need to remove the bias parameters.
regPart = lambda / 2 / m * (
	sum(sum(Theta1.^2)(2:end)) + 
	sum(sum(Theta2.^2)(2:end))
		);

J = -1/m .* sum(totalError) + regPart;


% 5000 by 10
Sigma2 = A2 - yy;

% 5000 by 26
Sigma1 = Sigma2*Theta2 .* (A1 .* (1-A1));

%10 by 26
Delta2 = Sigma2' * A1;

%26 by 401
Delta1 = Sigma1' * X;

% 25 by 401
size(Theta1);
% 10 by 26
size(Theta2);
% 26 by 401
size(Delta1);
% 10 by 26
size(Delta2);


D2 = 1/m .* (Delta2 + lambda.*Theta2);
D2(:,1) = D2(:,1) - 1/m .* (lambda.*Theta2(:,1));

Delta1Extra = Delta1(2:end,:);
% 25 by 401

D1 = 1/m .* (Delta1Extra + lambda.*Theta1);
D1(:,1) = D1(:,1) - 1/m .* (lambda.*Theta1(:,1));

Theta2_grad = D2;
Theta1_grad = D1;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
