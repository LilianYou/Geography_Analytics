%%% Lab1 Lily Cheng
%% 1.1 Write matlab scripts to evaluate the following equations:
% (A)
a = 2;
b = 4;
c = 8;
x = 3.5;
y = a.*(x.^2) + b.*x + c;
y % key: y = 46.5


% (B)
p0 = 1.6;
c = 4;
x = 3.5;
p = p0.*exp(-c.*x);
p % key: p = 1.3304e-06

% (C)
h = 4;
theta = 31*pi/180;%radiant
z = h.*sin(theta);
z % key: z = 2.0602

% (D)
h = 6.9;
r = 3.7;
v = pi.*h.*(r.^2);
v % key: v = 296.7580

%% 1.2 

a = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; % nonleap year
b = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]'; % leap year
C = a*b;
C % key: C = 11139

%% 1.3 

M = [ [1,0,0,0]',[-1,1,0,0]',[0,-1,1,0]',[0,0,-1,1]'];
y = [1, 2, 3, 5]';
N = inv(M);
M*N % check inv
x = N*y;
x % key: x = [11,10,8,5]'
%% 1.4 Toeplitz
c = [1, zeros(1,49)];
r = [0, -1, zeros(1,48)];
M = toeplitz(c,r);
M

%% 1.5 Rivers always flow downstream. Write a Matlab script to check that none of the Neuse River discharge data is negative.
D = load('neuse-1.5.txt');
t = D(:,1);
d = D(:,2);

% there are two ways to check whether there is negative river discharge
% data: (1) visually tell it from a Neuse River Hydrograph (2) count the
% number of values in discharge column that is smaller than 0

% (1) Neuse River Hydrograph
figure(1)
set(gca,'LineWidth',2);
plot(t,d,'k-','LineWidth',2);
title('Neuse River Hydrograph');
xlabel('time in days');
ylabel('discharge in cfs');

% key: from the plot, no dot value falls below x axis, there is no negative
% discharge data.

% (2) count number of negative values
j = 0;
for i = d
    if i < 0
        j = j + 1;
    else
        j = j;
    end
end

j % key: j = 0, turns out that there is no negative discharge data.
        
%% 1.6 What is the largest hourly change in temperature in the Black Rock Forest dataset? Ignore the changes that occur at the temperature spikes and drop-outs.
clc;

D = load('brf_temp-1.6.txt');
t = D(:,1);
d = D(:,2);
% plot
figure(2) % time-temperature plot
set(gca,'LineWidth',2);
plot(t,d,'k-','LineWidth',2);
title('Black Rock Forest Temperature');
xlabel('time in days');
ylabel('temperature');

figure(3) % time - temperature change plot
change = diff(d);
set(gca,'LineWidth',2);
plot(t(2:end),change,'k-','LineWidth',2);
title('Black Rock Forest Temperature Change');
xlabel('time in days');
ylabel('temperature change');

% By comparing figure(2) and figure(3), I find the largest hourly
% change in temperature. From figure(3), I can tell the largest
% positive point falls in the range of 4400day till the end (the largest negative
% point has bigger absolute value than the largest, but it's a dropout so
% is not considered here). In order to find the value of the largest hourly
% change, I apply the following script:

hr_per_day = 24;
L_change = change(4000*hr_per_day:end);
largest_value = max(L_change);
largest_value % key: largest_value = 19.902

% Therefore, the largest hourly change in temperature in the Black Rock
% Forest dataset is 19.902.

%% 1.7 Create histograms for the eight chemical species in the Atlantic Rock dataset.
clc;

D = load('rocks-1.7.txt');

figure(4)

for i = [1:1:8]  
    subplot(4,2,i)
    histogram(D(:,i))
    title(['species',num2str(i)])
end

