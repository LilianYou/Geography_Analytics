% Lines preceded by a percent symbol (%) are comments - they are not read by
% MATLAB.

% To run this script: Place this script and the drifter data that you want
% to open in the same directory. Start up MATLAB. Type "hw1_open"
% (without the quotes) at the MATLAB prompt to run this script. Then type
% "whos" (no quotes) to see which variables are in your workspace. You can
% modify this script and save it for later use (so you don't have to re-do
% all your commands in MATLAB).

% load the daily drifter data
fid = fopen('drifter_46926_aug2014_daily.csv');
data = textscan(fid,'%f%{MMM d, yyyy hh:mm a}D%f%f','HeaderLines',1,'Delimiter',',');
fclose(fid);

% extract the data
t = data{2}; % the second column is the date/time
lon = data{3}; % the third column in longitude
lat = data{4}; % the fourth column is latitude

% calculate the time elapsed in hours
% want to make the first time = 0
time_elapsed_hours = 24*day(t)+hour(t)-24*day(t(1));

% now you can analyze the data and do the plots, answer the questions etc.

%% Question Set A
% question a
figure(1)
plot(lon,lat)
xlabel('longitude')
ylabel('latitude')
title('Daily Drifter Position')
% question b
figure(2)
subplot(2,1,1)
plot(time_elapsed_hours,lon)
xlabel('time(hours)')
ylabel('longitude')
% question c
figure(3)
subplot(2,1,1)
plot(time_elapsed_hours,lat)
xlabel('time(hours)')
ylabel('latitude')


x = cos(lon*2*pi/360)*111.2*1000*100;  %longitude
y = lat*1000*100;%latitude
nx = length(x);
dx = x(2:nx)- x(1:nx-1);% x, longitude difference
%dx = 111.2*cos(0.5*(y(2:nx)+y(1:nx-1))*pi/180)*(x(2:nx)-x(1:nx-1))*pi/180;

dy = (y(2:nx)- y(1:nx-1)); % y, latitude difference
dt = 60*60*24; %in second
v_x = dx./dt;
v_y = dy./dt;
t1 = 0.5*(time_elapsed_hours(2:nx)+time_elapsed_hours(1:(nx-1)));

% d(1)
figure(2)
subplot(2,1,2)
plot(t1,v_x)
xlabel('time(hours)')
ylabel('x component of drifter velocity')

% d(2)
figure(3)
subplot(2,1,2)
plot(t1,v_y)
xlabel('time(hours)')
ylabel('y component of drifter velocity')
%e
speed = (v_x.^2 + v_y.^2).^(1/2); %  speed of the drifter
figure(4)
plot(t1,speed)
month = 30;
speed_month = sum(speed)/month;
xlabel('time(hours)');
ylabel('drifter speed');
%f
lon_max = max(lon);
lon_min = min(lon);
%t_max = interp1(lon,t,lon_max);
%t_min = interp1(lon,t1,lon_min);

%% B Question
% load the daily drifter data
fid_h = fopen('drifter_46926_aug2014_hourly.csv');
data_h = textscan(fid_h,'%f%{MMM d, yyyy hh:mm a}D%f%f','HeaderLines',1,'Delimiter',',');
fclose(fid_h);

% extract the data
t_h = data_h{2}; % the second column is the date/time
lon_h = data_h{3}; % the third column in longitude
lat_h = data_h{4}; % the fourth column is latitude

% calculate the time elapsed in hours
% want to make the first time = 0
time_elapsed_hours_h = 24*day(t_h)+hour(t_h)-24*day(t_h(1));

x_h = cos(lon_h*2*pi/360)*111.2*1000*100;  %longitude
y_h = lat_h*1000*100;%latitude
nx_h = length(x_h);
dx_h = x_h(2:nx_h)- x_h(1:nx_h-1);% x, longitude difference
dy_h = (y_h(2:nx_h)- y_h(1:nx_h-1)); % y, latitude difference
dt_h = 60*60; %in second
v_x_h = dx_h./dt_h;
v_y_h = dy_h./dt_h;
t1_h = 0.5*(time_elapsed_hours_h(2:nx_h)+time_elapsed_hours_h(1:(nx_h-1)));




% question a

figure(1)
plot(lon,lat)
hold on
plot(lon_h,lat_h)

xlabel('longitude')
ylabel('latitude')
title('Drifter Position')

% question b
figure(2)
subplot(2,1,1)
plot(time_elapsed_hours,lon)
hold on
plot(time_elapsed_hours_h,lon_h)
xlabel('time(hours)')
ylabel('longitude')


subplot(2,1,2)
plot(t1,v_x)
hold on
plot(t1_h,v_x_h)

xlabel('time(hours)')
ylabel('x component of drifter velocity')

% question c
figure(3)
subplot(2,1,1)
plot(time_elapsed_hours,lat)
hold on
plot(time_elapsed_hours_h,lat_h)
xlabel('time(hours)')
ylabel('latitude')

subplot(2,1,2)
plot(t1,v_y)
hold on
plot(t1_h,v_y_h)
xlabel('time(hours)')
ylabel('y component of drifter velocity')

% question e
speed = (v_x.^2 + v_y.^2).^(1/2); %  speed of the drifter
speed_h = (v_x_h.^2 + v_y_h.^2).^(1/2);

figure(4)
plot(t1,speed)
hold on
plot(t1_h,speed_h)
month_h = 30*24;
speed_month_h = sum(speed_h)/month_h;
xlabel('time(hours)');
ylabel('drifter speed (m/s)');