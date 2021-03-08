%% B Question
% load the daily drifter data
fid_h = fopen('drifter_46926_aug2014_hourly.csv');
data_h = textscan(fid_h,'%f%{MMM d, yyyy hh:mm a}D%f%f','HeaderLines',1,'Delimiter',',');
fclose(fid_h);

% extract the data
t_h = data_h{2}; % the second column is the date/time
lon_h = data_h{3}; % the third column in longitude
lat_h = data_h{4}; % the fourth column is latitude

%n = [1:1:32];
%lon_d(n) = (sum(lon_h((24*(n-1)+1):(24*(n-1)+24))))/24;
%lat_d(n) = (sum(lat_h((24*(n-1)+1):(24*(n-1)+24))))/24;

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
%plot(lon,lat)
%hold on
plot(lon_h,lat_h)

xlabel('longitude')
ylabel('latitude')
title('Drifter Position')

% question b
figure(2)
subplot(2,1,1)
%plot(time_elapsed_hours,lon)
%hold on
plot(time_elapsed_hours_h,lon_h)
xlabel('time(hours)')
ylabel('longitude')


subplot(2,1,2)
%plot(t1,v_x)
%hold on
plot(t1_h,v_x_h)

xlabel('time(hours)')
ylabel('x component of drifter velocity')

% question c
figure(3)
subplot(2,1,1)
%plot(time_elapsed_hours,lat)
%hold on
plot(time_elapsed_hours_h,lat_h)
xlabel('time(hours)')
ylabel('latitude')

subplot(2,1,2)
%plot(t1,v_y)
%hold on
plot(t1_h,v_y_h)
xlabel('time(hours)')
ylabel('y component of drifter velocity')

% question e
%speed = (v_x.^2 + v_y.^2).^(1/2); %  speed of the drifter
speed_h = (v_x_h.^2 + v_y_h.^2).^(1/2);

figure(4)
%plot(t1,speed)
%hold on
plot(t1_h,speed_h)
month_h = 30*24;
speed_month_h = sum(speed_h)/month_h;
xlabel('time(hours)');
ylabel('drifter speed (m/s)');