dx = .01;
dy = .01;

x = [0:dx:10];
y = [0:dy:10];
nx = length(x);
ny = length(y);

[X,Y] = meshgrid(x,y);

% equation
Z = sin(X./1.4)+cos(Y./1.4)+(exp(X./4)).^(1/2);

% calculate the partial derivatives
dX = X(:,2:nx)-X(:,1:nx-1);
dZx = Z(:,2:nx)-Z(:,1:nx-1);
Z_X = dZx./dx;

figure(1)
contourf(Z_X) % the f fills in the contours
figure(2)
surf(Z_X)
shading('flat') % removes the gridlines

dY = diff(Y,1,1); % for diff(variable, nth order of derivative, dimension)
dZy = diff(Z); 
Z_Y = dZy./dy;

figure(3)
contourf(Z_Y)
figure(4)
surf(Z_Y)
shading('flat') % removes the gridlines

figure(5)
surf(Z)
shading('flat')

% calculate the midpoints so matrices match 100x100
Z_X_mid = .5*(Z_X(2:nx,:)+Z_X(1:nx-1,:));
Z_Y_mid = .5*(Z_Y(:,2:ny)+Z_Y(:,1:ny-1));
s = ((Z_X_mid).^2+(Z_Y_mid).^2).^(1/2);

figure(6)
subplot(2,1,1)
contourf(s)
subplot(2,1,2)
surf(s)
shading('flat')

% calculate the second-order partial derivatives
ddZx = diff(dZx,1,2);
Z_XX = ddZx./dx;

ddZy = diff(dZy,1,1);
Z_YY = ddZy./dy;

Z_XY = ddZx./(dx*dy);
Z_YX = ddZy./(dx*dy);

figure(7)
subplot(2,1,1)
contourf(Z_XX)
subplot(2,1,2)
surf(Z_XX)
shading('flat')

figure(8)
subplot(2,1,1)
contourf(Z_YY)
subplot(2,1,2)
surf(Z_YX)
shading('flat')

figure(9)
subplot(2,1,1)
contourf(Z_XY)
subplot(2,1,2)
surf(Z_XY)
shading('flat')