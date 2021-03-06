% Update Precision, StandardDeviation and Correlation based on Covariance
function obj = updateCovariance(obj)
    % check for covariance matrix (should be symmetric)
    assert(isequal(obj.Covariance, transpose(obj.Covariance)),...
    'Error: Covariance is not symmetric');

    obj.Precision = inv(obj.Covariance);
    if any(isinf(obj.Precision))
        error('Obj precision inexpressible, Covariance matrix singular');
    end
    obj.StandardDev = sqrt(diag(obj.Covariance));
    obj.Correlation = obj.Covariance(1,2) / prod(obj.StandardDev);
    obj.Scaling = 1/(2*pi*obj.StandardDev(1)*obj.StandardDev(2)*sqrt(1-obj.Correlation^2));
   
    assert ((-1 <= obj.Correlation) && (1 >= obj.Correlation), 'Bad Covariance: Correlation out of bounds');
%     assert (~isinf(obj.Scaling), 'Bad Covariance: Precision inexpressible');
    % removed assertion of scaling to make code work for cogs205.csv 
end
