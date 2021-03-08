load('socal_elevation_v2.mat')
dy = 0.0415;
dx = 0.0344;
x = lon;
y = lat;

nx = length(lon);
ny = length(lat);

[X,Y]= meshgrid(x,y);
Z = hgt;
%% question1
figure(1)
contourf(X,Y,Z) 
colorbar
xlabel('Longitude')
ylabel('latitude')
title('Surface Elevation')
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')


%% question2
% 2a

dY = diff(Y,1,1); % for diff(variable, nth order of derivative, dimension)
dZy = diff(Z,1,1); 
Z_Y = dZy./dy;

dX = diff(X,1,2);
dZx = diff(Z,1,2); 
Z_X = dZx./dx;

figure(2)
subplot(2,1,1)
contourf(X(:,1:149),Y(:,1:149),Z_X)
title('Partial Derivative on X Direction')
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')
colorbar
subplot(2,1,2)
contourf(X(1:146,:),Y(1:146,:),Z_Y)
colorbar
title('Partial Derivative on Y Direction')
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')

%2b south-north direction


%% 3
% 3a

Z_Y_mid = 0.5*(Z_Y(1:ny-2,1:148)+Z_Y(2:ny-1,1:148));
Z_X_mid = 0.5*(Z_X(1:145,2:nx-1)+Z_X(1:145,1:nx-2));
s = ((Z_X_mid).^2+(Z_Y_mid).^2).^(1/2);

figure(3)
contourf(X(1:145,1:148),Y(1:145,1:148),s)
xlabel('Longitude')
ylabel('Latitude')
title('Magnitude of the Gradient Vector')
colorbar
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')


% the region that is the steepest is 

%% 4
% % calculate the second-order partial derivatives
ddZx = diff(dZx,1,2);
Z_XX = ddZx./dx;

ddZy = diff(dZy,1,1);
Z_YY = ddZy./dy;


figure(4)
subplot(2,1,1)
contourf(X(:,1:148),Y(:,1:148),Z_XX)
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('the Second Derivatives in the x-directions')
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')

subplot(2,1,2)
contourf(X(1:145,:),Y(1:145,:),Z_YY)
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('the Second Derivatives in the y-directions')
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')

%%5
% Santa Barbara lat: 34.420830 lon: -119.698189
% Los Angeles lat: 34.052235 lon: -118.243683
% Lancaster lat: 34.686787 lon: -118.154160
% San Luis Obispo lat: 35. 28275 lon: -120.65962
% Bakersfield lat: 35.393528 lon: -119.022102
% San Diego lat: 32.715736 lon: -117.161087
% Palm Springs lat: 33.8303 lon: -116.54529
% Channel Islands lat: 49.216667 lon: -2.1325
% Point Conception lat: 34.4486 lon: -120.4716
% Salton Sea lat: 33.333 lon: -115.8342
% San Joaquin Valley lat: 36.689 lon: -120.0071
% San Bernardino mountains lat: 34.1255662 lon: -116.8764152
% Santa Ynez mountains lat: 34.4944 lon: -119.7126
% Sierra Nevada mountains lat: 35.432394 lon: -118.588692

figure(7)
contourf(Z)
colorbar
text(-119.698189,34.420830,'Santa Barbara')
text(-118.243683,34.052235,'Los Angeles')
text(-118.154160,34.686787,'Lancaster')
text(-120.65962,35.28275,'San Luis Obispo')
text(-119.022102,35.393528,'Bakersfield')
text(-117.161087,32.715736,'San Diego')
text(-116.54529,33.8303,'Palm Springs')
text(-119.769163,33.996074,'Channel Islands')
text(-120.471439,34.448113,'Point Conception')
text(-115.8342,33.333,'Salton Sea')
text(-120.0071,36.689,'San Joaquin Valley')
text(-116.8764152,34.1255662,'San Bernardino mountains')
text(-119.7126,34.4944,'Santa Ynez mountains')
text(-118.588692,35.432394,'Sierra Nevada mountains')
figure(8)
surf(Z)
shading('flat')