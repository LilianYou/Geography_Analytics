%%% Question1

data=load('ding-data1.txt');
year = data(:,1);
month = data(:,2);
X = data(:,3);
n = length(X);
time = [1:1:n];

%% 1. plot X (vs time)
figure(1)

plot(time,X)
xlabel('Number of Months');
ylabel('X')
title('X over Time')

%% 2. 
Mean_x = mean(X);
X1 = X - Mean_x;
[pxx, f] = periodogram(X1);

figure(2);
plot(f, pxx), grid;
title('Power Spectrum of X (remove the mean of X) as Function of Frequency')

figure(3);
plot(1./f, pxx), grid;
title('Power Spectrum of X (remove the mean of X) as Function of Period')

%% 3.
figure(4);
cwt(X1);

%%% Question2
data2=load('ding-data2.txt');
year = data2(:,1);
month = data2(:,2);
X = data2(:,3);
Y = data2(:,4);
m = length(Y);
time2 = [1:1:m];

%%1 plot X and Y together (vs time).

figure(5)
plot(time2,X)
hold on
plot(time2,Y)
hold off
xlabel('Number of Months');
ylabel('Variable')
title('X and Y Over Time')
legend('X','Y');

%% 2 Use FFT and periodogram calculate (and plot) the power spectrum of X (remove the mean first), respectively.
Mean_x = mean(X);
X2 = X - Mean_x;

% periodogram
[pxx, f] = periodogram(X2);
figure(6);
plot(f, pxx),grid;
title('Power Spectrum of X (remove the mean of X)')

% FFT
Xxx = fft(X2,1024);
Pxx2 = abs(Xxx).^2/1000;
Pxx = [Pxx2(1); 2*Pxx2(2:512)];
f2 = 0:1/(1024-1):1/2;
figure(7);
plot(f2, Pxx),grid;
title('Power Spectrum of X (remove the mean of X)')

%% 3. Calculate and plot the cross-spectrum between X and Y (remove the means of X and Y).

Mean_y = mean(Y);
Y2 = Y - Mean_y;

[Pxy,f3] = cpsd(X2, Y2, [], 0, 1024,1);
figure(8);
plot(f3, abs(Pxy)),grid;
title('cross-spectrum between X and Y (remove the means of X and Y)')

%% Use a low-pass filter to remove any high frequency variability (higher than the 2-year periods) from X and Y and plot the residual time series of X and Y together.

[bx, ax] = butter(1, (1/24)/0.5);
[hx, wx] = freqz(bx, ax, 1024);
fx = 1*wx/(2*pi);
xfx = filtfilt(bx,ax,X);

[by, ay] = butter(1, (1/24)/0.5);
[hy, wy] = freqz(by, ay, 1024);
fy = 1*wy/(2*pi);
yfy = filtfilt(by,ay,Y);

figure(9);
plot(time2,xfx)
hold on
plot(time2,yfy)
hold off
xlabel('Number of Months');
ylabel('Variable')
title('Residual X and Y Over Time')
legend('X','Y');