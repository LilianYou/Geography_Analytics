%make a grid
dx = 0.1; %resolution of grid
dy = 0.1;
x = [0:dx:10]; % domain of interest
y = [0:dy:10]; % y-domain
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);

%%plot x
%plot first row of x
plot(X(1,:)) % first row of all columns of X
plot(Y(1,:)) % first row of all columns of Y

%whatever data
Z = (X-5).^2 + 0.5*(Y-2).^2;

%visualize using contour or surf
figure(1)
clf
contourf(X,Y,Z)

figure(2)
clf
surf(X,Y,Z)

%%calculate derivatives
% partial derivative of z with respect to x
dX = X(:,2:nx)-X(:,1:nx-1); % dx= x(2:nx)-x(1:nx-1)
dZx = Z(:,2:nx)-Z(:,1:nx-1); % dZ in x-direction
Z_x = dZx./dX; % Z_x is shorthand for dz/dx
%same in y-direction but ny
%colormap(winter), colorbar

%plot x derivative at the mid points
Xmx = 0.5*(X(:,1:nx-1)+X(:,2:nx));
Ymx = Y(:,2:nx); % just taking the last 2:nx elements of Y in x-direction
figure(3)
contourf(Xmx,Ymx,Z_x)
