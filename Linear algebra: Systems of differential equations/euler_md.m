% define A matrix
A = [-1 0; 0 1];

% define q(v)
q = @(x,y)[x.*y; -x.*y];

dt = 0.01;
t = [0:dt:20];
nt = length(t);

% initial conditions
v0 = [2,10]';

v(:,1) = v0;

% pass through 
for i = 2:nt   
    v(:,i) = v(:,i-1) + dt*(A*v(:,i-1)+q(v(1,i-1),v(2,i-1)));
end

 figure(1)
 plot(t,v')
 legend('x','y')

 F = jacobian(A,v);
 itc = 0;
 v = v0;
 while norm(F)>1e-3
     
     [F,J] = jacobian(A,v);
     
     
     v = v - J\F;
     
     itc = itc + 1;
     
 end