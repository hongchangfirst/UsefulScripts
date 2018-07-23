function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);



% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

%Theta1 size 25*401
%Theta2 size 10*26
% X is 5000*400

X = [ones(m,1) X];
% X now is 5000*401


Layer1 = sigmoid(X*Theta1');
%Layer1 size 5000*25

Layer1 = [ones(m,1) Layer1];
%Layer1 size now is 5000*26
Layer2 = sigmoid(Layer1*Theta2');

% v is the max value(probability), p is the max value index(classification)
[v,p] = max(Layer2,[],2);


% =========================================================================


end
