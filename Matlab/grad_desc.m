% Gradient Descent function. Finds minimum of 'f' using gradient 'f_grad'
%   with initial guess at 'x0'. Stopping criteria 'tol' is the distance 
%   between sucessive iterations. If stepsize 't' <= 0, then a backtracking 
%   linesearch is used. Otherwise, use t as the constant stepsize. Variable
%   arguments determine values of 'rho' and 'c' in the backtracking 
function [x] = grad_desc( f, f_grad, x0, tol, max_iter, t, varargin )
    % Store each iteration for error checking
    x(:, 1) = x0;
    
    % Define initial stepsize if backtracking is requested
    t_start = -1;
    if t <= 0
        t_start = 10;
    end
    
    % Use variable arguments to set backtracking constants
    if nargin == 6
        rho = 0.9;
        c = 1e-4;
    elseif nargin == 7
        rho = varargin{1};
        c = 1e-4;
    else
        rho = varargin{1};
        c = varargin{2};
    end
    
    for i = 1:max_iter
        % Pick search direction
        pk = -f_grad( x(:,i) );
        
        % Choose stepsize with backtracking, skipping if it is fixed
        if t_start >= 0
            t = t_start;
            fs =  f(x(:,i))
            while f( x(:,i) + t*pk ) > fs - c*t*dot( pk, pk )
                t = rho*t;
            end
            
            % If we satisfy the Armijo condition on the first try,
            %   double our starting stepsize. Otherwise, start with the
            %   same t as last time.
            if t == t_start
                t_start = 1.1*t_start;
            else
                t_start = t;
            end
        end
        
        % Perform gradient descent step
        x(:,i+1) = x(:,i) + t*pk;

        % Stop if error tolerance is reached
        if norm( x(:,i+1) - x(:,i) ) < tol
            break;
        end
    end
end
