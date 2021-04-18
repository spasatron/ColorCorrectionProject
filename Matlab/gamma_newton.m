function gamma = gamma_newton(image,g,tol,N)
% Returns the gamma such that f(gamma,pix,c) = 0 through Newton's

% Input:
% RBG       RGB values of the image
% gamma     gamma value for the channel
% tol       acceptable tolerance
% N         maximum number of iterations

% Output:
% gamma     a vector containing the gamma values for all three channels in
%           the order they are given in image

    image = reshape(image,[size(image,1).*size(image,2),3]); 
    c = sum(image(:,3).^g); % weighted average of channel to normalize against
    f = @(x,pix,c) [sum(pix(:,1).^x(1)),sum(pix(:,2).^x(2))] - c; % function
    fp = @(x,pix) [sum(log(pix(:,1)).*(pix(:,1).^x(1))),sum(log(pix(:,2)).*(pix(:,2).^x(2)))]; % derivative of function
    
    % initialize Newton's
    k = 0;
    x0 = [1,1];
    x1 = x0 - f(x0,image(:,1:2),c)./fp(x0,image(:,1:2));
    feval = f(x1,image(:,1:2),c);
    
    % Newton's method 
    while and(max(feval) > tol,k < N)
        x0 = x1;
        x1 = x0 - feval./fp(x0,image(:,1:2)); % Newton step
        feval = f(x1,image(:,1:2),c);
        k = k + 1;
    end
    
    gamma = [x1,g];
    
%     Confirm results
%     C1 = sum(2.*image(:,1).^gamma(1) - image(:,2).^gamma(2) - image(:,3).^gamma(3));
%     C2 = sum(2.*image(:,2).^gamma(2) - image(:,1).^gamma(1) - image(:,3).^gamma(3));
%     C3 = sum(2.*image(:,3).^gamma(3) - image(:,2).^gamma(2) - image(:,1).^gamma(1));
%     max(abs([C1,C2,C3]))
end