% (a) v = [x;y]  bold A = [A,0;0,B]  q(v) = [-(P*(x.^2) + Q*x*y);-(R*x*y +
% S(y.^2))]  r= [C;D]

% (b)
A1 = 0.2;
P = 0.1;
Q = 0.1;
B = 0.3;
R = 0.2;
S = 0.1;
C = 5;
D = 10;

A = [A1,0;0,B];
q = @(x,y)[-(P.*(x.^2) + Q.*x.*y);-(R*x.*y + S.*(y.^2))];
r = [C;D];

% time domain
dt = .01;
t = [0:dt:20];
nt = length(t);

% initial conditions
v0 = [10 10]';

v(:,1) = v0;

% pass through 
for i = 2:nt   
    v(:,i) = v(:,i-1) + dt*(A*v(:,i-1)+q(v(1,i-1),v(2,i-1))+r);
end

figure(1)
plot(t,v')
legend('model of population x','model of population y')
xlabel('Time')
ylabel('Resources')
title('Resources of Different Population Models Over Time')
grid on
grid minor

% c
% linear part of system (A)
A = [A1,0;0,B];

% constants
r = [C;D];

% initial guess
v = [10 10]'; % v = [x y]'

% iterate to solution with Newton's method
F = myfunc_q7(v,A,r); % initial function evaluation
itc = 0; % iteration counter
while norm(F)> 1e-3 % le-3 tolerance
    
    % evaluate function and Jacobian
    [F,J] = myfunc_q7(v,A,r);
    
    % update v with Newtion step
    v = v - .1*(J\F);
    
    % update iteration counter
    itc = itc + 1;
    
    % collect (x,y) values
    xi(itc)=v(1);
    yi(itc)=v(2);
    
    % evaluate function and Jacobian
    [F,J] = myfunc_q7(v,A,r);
        % plot the norm of the function
    figure(2)
    plot(itc,norm(F),'*','DisplayName',['Iteration', num2str(itc)])
    hold on 
    plot(itc,v(1),'go','DisplayName',['Iteration', num2str(itc)])
    hold on 
    plot(itc,v(2),'r+','DisplayName',['Iteration', num2str(itc)])
    
    legend('||F||','x','y')
    drawnow % tell matlab to make plot 
    set(gca,'YGrid','on')
    set(gca,'XGrid','on')
    xlabel('Newton Iteration')
    ylabel('norm of function and variable values')
    title('Newton method: Norm of function and Value of variables')
end
grid minor