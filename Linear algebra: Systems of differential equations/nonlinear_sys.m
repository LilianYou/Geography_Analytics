% solve non-linear system of equations
% 2x + 3y - 2xy =10
% 5x - 2y + 4xy = 6
%
% General form: A*v + q(v) = r
% Use Newton's method to find v such that F(v) = A*v + q(v) -r = 0

% linear part of system (A)
A = [2 3;5 -2];

% constants
r = [10 6]';

% initial guess
v = [100 100]'; % v = [x y]'

% iterate to solution with Newton's method
F = myfun_sec9(v,A,r); % initial function evaluation
itc = 0; % iteration counter
while norm(F)> 1e-3 % le-3 tolerance
    
    % evaluate function and Jacobian
    [F,J] = myfun_sec9(v,A,r);
    
    % update v with Newtion step
    v = v - J\F;
    
    % update iteration counter
    itc = itc +1;
    
    % collect (x,y) values
    xi(itc)=v(1);
    yi(itc)=v(2);
    
    % evaluate function and Jacobian
    [F,J] = myfun_sec9(v,A,r);
    
    % plot the norm of the function
    figure(1)
    plot(itc,norm(F),'*','DisplayName',['Iteration', num2str(itc)])
    hold on 
    drawnow % tell matlab to make plot 
    set(gca,'YGrid','on')
    set(gca,'XGrid','on')
    xlabel('Newton Iteration')
    ylabel('norm of function')
    
    
end
legend(gca,'show')