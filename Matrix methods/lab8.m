%%% Q1
D1 = load('x.txt');
D2 = load('y.txt');
T1 = D1(:,1);
X = D1(:,2);
T2 = D2(:,1);
Y = D2(:,2);

%% 1. linear method

i = 1:92;
X_linear = interp1(T1,X,i, 'linear');
Y_linear = interp1(T2,Y,i, 'linear');

corr_linear = corrcoef(X_linear, Y_linear) % 0.7871

%% 2. nearest method
X_nearest = interp1(T1,X,i, 'nearest');
Y_nearest = interp1(T2,Y,i, 'nearest');
corr_nearest = corrcoef(X_nearest, Y_nearest) %0.7894

%% 3. cubic method
X_cubic = interp1(T1,X,i, 'cubic');
Y_cubic = interp1(T2,Y,i, 'cubic');
corr_cubic = corrcoef(X_cubic, Y_cubic)  %0.7888

%% 4. spline method
X_spline = interp1(T1,X,i, 'spline')
Y_spline = interp1(T2,Y,i, 'spline')
corr_spline = corrcoef(X_spline, Y_spline) %0.7900

% Based on the correlation coefficient, spline method gives the best
% result.

%%% Q2
m = 10; % example imaging size
pic = rand(m,m);
s = 16; 
[m,n] = size(pic);
[X, Y] = meshgrid(1:m);
[XI,YI] = meshgrid(linspace(1,m,s*m-1));

pic_linear = interp2(X,Y,pic,XI,YI,'linear');
pic_nearest = interp2(X,Y,pic,XI,YI,'nearest');
pic_cubic = interp2(X,Y,pic,XI,YI,'cubic');
pic_spline = interp2(X,Y,pic,XI,YI,'spline');

figure(1)
subplot(2,2,1)
imshow(pic_linear, [0,1])
title('linear')
hold on
subplot(2,2,2)
imshow(pic_nearest, [0,1])
title('nearest')
hold on
subplot(2,2,3)
imshow(pic_cubic, [0,1])
title('cubic')
hold on
subplot(2,2,4)
imshow(pic_spline, [0,1])
title('spline')



%%% Q3

%1. 
clear
clf
%%
load geost_dat.mat

%%
figure(1)
plot(x,y,'.')

%%
min(z)
max(z)

%%
figure(2)
histogram(z)
skewness(z)
kurtosis(z)

%%
[X1,X2] = meshgrid(x);
[Y1,Y2] = meshgrid(y);
[Z1,Z2] = meshgrid(z);

%%
D = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);

%%
G = 0.5*(Z1 - Z2).^2;

%%

indx = 1:length(z);
[C,R] = meshgrid(indx);
I = R > C;

%%
figure(3)
plot(D(I),G(I),'.' )
xlabel('lag distance')
ylabel('variogram')

%%
D2 = D.*(diag(x*NaN)+1);
lag = mean(min(D2))

%%
hmd = max(D(:))/2

%%
max_lags = floor(hmd/lag)

%%
LAGS = ceil(D/lag);

%%
for i = 1 : max_lags
 SEL = (LAGS == i);
 DE(i) = mean(mean(D(SEL)));
 PN(i) = sum(sum(SEL == 1))/2;
 GE(i) = mean(mean(G(SEL)));
end

%%
figure(4)
plot(DE,GE,'.' )
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
hold on

%%
plot(b,c, '--r')
yl = 1.1 * max(GE);
ylim([0 yl])
xlabel('Averaged distance between observations')
ylabel('Averaged semivariance')
hold off

%%
figure(5)
plot(DE,GE,'o','MarkerFaceColor',[.6 .6 .6])
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
hold on
plot(b,c,'--r')
xlim(b)
yl = 1.1*max(GE);
ylim([0 yl])

%%
nugget = 0;
sill = 0.803;
range = 45.9;
lags = 0:max(DE);
Gsph = nugget + (sill*(1.5*lags/range - 0.5*(lags/...
 range).^3).*(lags<=range) + sill*(lags>range));
plot(lags,Gsph,':g')

%%
nugget = 0.0239;
sill = 0.78;
range = 45;
Gexp = nugget + sill*(1 - exp(-3*lags/range));
plot(lags,Gexp,'-.b')

%%
nugget = 0.153;
slope = 0.0203;
Glin = nugget + slope*lags;
plot(lags,Glin,'-m')
xlabel('Distance between observations')
ylabel('Semivariance')
legend('Variogram estimator','Population variance',...
'Sperical model','Exponential model','Linear model')
hold off

%%
G_mod = (nugget + sill*(1 - exp(-3*D/range))).*(D>0);

%%
n = length(x);
G_mod(:,n+1) = 1;
G_mod(n+1,:) = 1;
G_mod(n+1,n+1) = 0;

%%
G_inv = inv(G_mod);

%%
R = 0 : 5 : 200;
[Xg1,Xg2] = meshgrid(R,R);

%%
Xg = reshape(Xg1,[],1);
Yg = reshape(Xg2,[],1);

%%
Zg = Xg * NaN;
s2_k = Xg * NaN;

%%
for k = 1 : length(Xg)
 DOR = ((x - Xg(k)).^2 + (y - Yg(k)).^2).^0.5;
 G_R = (nugget + sill*(1 - exp(-3*DOR/range))).*(DOR>0);
 G_R(n+1) = 1;
 E = G_inv * G_R;
 Zg(k) = sum(E(1:n,1).*z);
 s2_k(k) = sum(E(1:n,1).*G_R(1:n,1))+E(n+1,1);
end

%%
r = length(R);
Z = reshape(Zg,r,r);
SK = reshape(s2_k,r,r);

% rename variables

Xg1o = Xg1;
Xg2o = Xg2;
Zo = Z;
SKo = SK;
xo = x;
yo = y;
zo = z;
%%
figure(6)
subplot(1,2,1)
ho = pcolor(Xg1o,Xg2o,Zo);
set(ho,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Estimate')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
subplot(1,2,2)
h = pcolor(Xg1o,Xg2o,SKo);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Variance')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
hold on
plot(xo,yo,'ok')
hold off




%The best place I will add a sample is the point (200,0) because from
%the figure6 right plot we could know that the left lower corner is the one
%with less sample and biggest error, which will be the best place to add a
%sample.

%2. calculate and plot difference


%% insert point

% add one point

x(150) = 200;
y(150) = 0;
z(150) = 7.5;

%%
%figure(1)
%subplot(2,1,2)
%plot(x(150),y(150),'.')

%%
min(z)
max(z)

%%
% figure(2)
% subplot(2,1,2)
histogram(z(150))
skewness(z(150))
kurtosis(z(150))

%%
[X1,X2] = meshgrid(x);
[Y1,Y2] = meshgrid(y);
[Z1,Z2] = meshgrid(z);

%%
D = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);

%%
G = 0.5*(Z1 - Z2).^2;

%%

indx = 1:length(z);
[C,R] = meshgrid(indx);
I = R > C;

%%
% figure(3)
% subplot(2,1,2)
% plot(D(I),G(I),'.' )
% xlabel('lag distance')
% ylabel('variogram')

%%
D2 = D.*(diag(x*NaN)+1);
lag = mean(min(D2))

%%
hmd = max(D(:))/2

%%
max_lags = floor(hmd/lag)

%%
LAGS = ceil(D/lag);

%%
for i = 1 : max_lags
 SEL = (LAGS == i);
 DE(i) = mean(mean(D(SEL)));
 PN(i) = sum(sum(SEL == 1))/2;
 GE(i) = mean(mean(G(SEL)));
end

%%
% figure(4)
% subplot(2,1,2)
% plot(DE,GE,'.' )
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
% hold on

%%
% plot(b,c, '--r')
yl = 1.1 * max(GE);
ylim([0 yl])
% xlabel('Averaged distance between observations2')
% ylabel('Averaged semivariance2')
% hold off

%%
% figure(5)
% subplot(2,1,2)
% plot(DE,GE,'o','MarkerFaceColor',[.6 .6 .6])
var_z = var(z);
b = [0 max(DE)];
c = [var_z var_z];
% hold on
% plot(b,c,'--r')
% xlim(b)
yl = 1.1*max(GE);
ylim([0 yl])

%%
nugget = 0;
sill = 0.803;
range = 45.9;
lags = 0:max(DE);
Gsph = nugget + (sill*(1.5*lags/range - 0.5*(lags/...
 range).^3).*(lags<=range) + sill*(lags>range));
plot(lags,Gsph,':g')

%%
nugget = 0.0239;
sill = 0.78;
range = 45;
Gexp = nugget + sill*(1 - exp(-3*lags/range));
plot(lags,Gexp,'-.b')

%%
nugget = 0.153;
slope = 0.0203;
Glin = nugget + slope*lags;
% plot(lags,Glin,'-m')
% xlabel('Distance between observations2')
% ylabel('Semivariance2')
% legend('Variogram estimator','Population variance',...
% 'Sperical model','Exponential model','Linear model')
% hold off

%%
G_mod = (nugget + sill*(1 - exp(-3*D/range))).*(D>0);

%%
n = length(x);
G_mod(:,n+1) = 1;
G_mod(n+1,:) = 1;
G_mod(n+1,n+1) = 0;

%%
G_inv = inv(G_mod);

%%
R = 0 : 5 : 200;
[Xg1,Xg2] = meshgrid(R,R);

%%
Xg = reshape(Xg1,[],1);
Yg = reshape(Xg2,[],1);

%%
Zg = Xg * NaN;
s2_k = Xg * NaN;

%%
for k = 1 : length(Xg)
 DOR = ((x - Xg(k)).^2 + (y - Yg(k)).^2).^0.5;
 G_R = (nugget + sill*(1 - exp(-3*DOR/range))).*(DOR>0);
 G_R(n+1) = 1;
 E = G_inv * G_R;
 Zg(k) = sum(E(1:n,1).*z);
 s2_k(k) = sum(E(1:n,1).*G_R(1:n,1))+E(n+1,1);
end

%%
r = length(R);
Z = reshape(Zg,r,r);
SK = reshape(s2_k,r,r);

%%
figure(7)
subplot(1,2,1)
h = pcolor(Xg1,Xg2,Z-Zo);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Estimate Difference')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
subplot(1,2,2)
h = pcolor(Xg1,Xg2,SK-SKo);
set(h,'LineStyle','none')
axis equal
ylim([0 200])
title('Kriging Variance Difference')
xlabel('x-Coordinates')
ylabel('y-Coordinates')
colormap(jet)
colorbar
hold on
plot(x(150),y(150),'ok')
hold off

% Please find the plot in figure7 (above).