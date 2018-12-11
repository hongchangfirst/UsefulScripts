function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    % tp true positive
    % fp false positive, it's 1, but we predict it as 0.
    % fn false negative, it's 0, but we predict it as 1.
    % yval is the fact, pval is the predicted one, belongs to (0,1).
    
    
    predictions = (pval < epsilon);
    % This is WRONG, since it is not true positive. tp = sum( ~xor(yval, predictions) );
    tp = sum(yval & predictions);
    fp = sum( (yval == 1) & (predictions == 0) );
    fn = sum( (yval == 0) & (predictions == 1) );

    % To avoid warning: division by zero
    if (tp .+ fp) == 0
        precision = 0;
    else 
        precision = double(tp) ./ (tp .+ fp);
    end

    if (tp .+ fn) == 0
        recall = 0;
    else 
        recall = double(tp) ./ (tp .+ fn);
    end

    epsilon;
    % if tp is zero, then precision and recall are all zero, then divided by zero.
    if (precision + recall) == 0
        F1 = 0;
    else
        F1 = 2 .* precision .* recall ./ (precision .+ recall);
    end

    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
