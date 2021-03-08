% (a) plot z
%make a grid
dx = 0.1; %resolution of grid
dy = 0.1;
x = [-6:dx:6]; % domain of interest
y = [-6:dy:6]; % y-domain
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);

% z
Z = 2.*sin(X./2)+cos(Y)+exp(X./5);

%visualize using contour or surf
figure(1)
clf
contourf(X,Y,Z)

figure(2)
clf
surf(X,Y,Z)
shading('flat')
% (b) critical points. partial derivatives=0 "cite: https://www.mathworks.com/help/matlab/math/roots-of-polynomials.html#bus0f0s-1"
% manually calculate partial partial derivative of Z with respect to x
Z_x = @(x) cos(x./2)+(1/5).*exp(x./5); 
figure(3)
plot(x,Z_x(x))
grid on
hold on
f1 = fzero(Z_x,-4) %f1 = -3.3468
f2 = fzero(Z_x,4) % f2 = 4.0803
plot(f1,Z_x(f1),'r*')
hold on
plot(f2,Z_x(f2),'r*')
hold off
xlabel('x')
ylabel('Z_x')
title('Partial Derivative of Z with respect to x')

% manually calculate partial partial derivative of Z with respect to y
Z_y = @(y) -sin(y); 
figure(4)
plot(y,Z_y(y))
grid on
hold on
plot(-pi,Z_y(-pi),'r*')
hold on
plot(0,Z_y(0),'r*')
hold on
plot(pi,Z_y(pi),'r*')
hold off
xlabel('y')
ylabel('Z_y')
title('Partial Derivative of Z with respect to y')

% (c) determine critical points

% c1(-3.3468,-pi);c2(-3.3468,0);c3(-3.3468,pi);c4(4.0803,-pi);c5(4.0803,0);c6(4.0803,pi)
H1 = second_partial_derivative_test(-3.3468,-pi) % H1 = 0.5179  Z_yy = 1>0 minimum
H2 = second_partial_derivative_test(-3.3468,0) % H2 = -0.5179 saddle
H3 = second_partial_derivative_test(-3.3468,pi) % H3 = 0.5179  Z_yy = 1>0 minimum
H4 = second_partial_derivative_test(4.0803,-pi) % H4 = -0.3555 saddle
H5 = second_partial_derivative_test(4.0803,0) % H5 = 0.3555 Z_yy = -1 <0 maximum
H6 = second_partial_derivative_test(4.0803,pi) % H1 = -0.3555 saddle

2.*sin(-3.3468./2)+cos(-pi)+exp(-3.3468./5) C1 -2.4774
2.*sin(-3.3468./2)+cos(pi)+exp(-3.3468./5) C3 -2.4774

% (d)
% calculate the partial derivatives
% partial derivative of z with respect to x
dX = X(:,2:nx)-X(:,1:nx-1); % dx= x(2:nx)-x(1:nx-1)
dZx = Z(:,2:nx)-Z(:,1:nx-1); % dZ in x-direction
Z_x = dZx./dX; % Z_x is shorthand for dz/dx

%plot x derivative at the mid points
Xmx = 0.5*(X(:,1:nx-1)+X(:,2:nx));
Ymx = Y(:,2:nx); % just taking the last 2:nx elements of Y in x-direction
figure(5)
contourf(Xmx,Ymx,Z_x)
colormap(winter)
colorbar
title('dz/dx')

% plot z derivative with respect to y
dY = diff(Y,1,1); % for diff(variable, nth order of derivative, dimension)
dZy = diff(Z); 
Z_y = dZy./dy;
%plot y derivative at the mid points
Xmy = 0.5*(X(1:ny-1,:)+X(2:ny,:));
Ymy = Y(2:ny,:); % just taking the last 2:nx elements of Y in x-direction
figure(6)
contourf(Z_y)
colormap(summer)
colorbar
title('dz/dy')