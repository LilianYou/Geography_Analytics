% open data
M = importdata('API_SP.POP.TOTL_DS2_en_csv_v3.csv');
data = M.data;
headers = M.textdata;

% the year is the first row
% the rest of the rows are the population data
year = data(1,:);

% find the relevant countries (the index of the row for each country)
ilow = find(strcmp(M.textdata,'Low income'));
ilowmid = find(strcmp(M.textdata,'Lower middle income'));
ihigh = find(strcmp(M.textdata,'High income'));
ijapan = find(strcmp(M.textdata,'Japan'));
ichina = find(strcmp(M.textdata,'China'));
ius = find(strcmp(M.textdata,'United States'));

% now you can make the plots, answer the questions etc.
%% Problem 1
% a

low_country = data(ilow,:);
lowmid_country = data(ilowmid,:);
high_country = data(ihigh,:);
figure(1)
plot(year,low_country./(10^6),'o')
hold on
plot(year, lowmid_country./(10^6),'o')
hold on
plot(year, high_country./(10^6),'o')
xlabel('Time (years)')
ylabel('Population (millions)')
set(gca, 'YScale','log')
title('Population Over Time (log scale)')
% b
nt = length(year);
d_low = low_country(2:nt) - low_country(1:nt-1);
d_lowmid = lowmid_country(2:nt) - lowmid_country(1:nt-1);
d_high = high_country(2:nt) - high_country(1:nt-1);
dt = year(2:nt)-year(1:nt-1);
d_low_dt = d_low./dt;
d_lowmid_dt = d_lowmid./dt;
d_high_dt = d_high./dt;
tmid = .5*(year(2:nt)+year(1:nt-1));
figure(2)
plot(tmid, d_low_dt./(10^6),'o')
hold on
plot(tmid, d_lowmid_dt./(10^6),'o')
hold on
plot(tmid, d_high_dt./(10^6),'o')
xlabel('Time (years)')
ylabel('Growth Rates (millions of people/year)')
set(gca, 'YScale','log')
title('Population Growth Rate Over Time')
%c
% when you plot a derivetive and it's a linear, if fits for the exponential
%d
d_lowmid = lowmid_country(2:nt) - lowmid_country(1:nt-1);
dt = year(2:nt)-year(1:nt-1);
d_lowmid_dt = d_lowmid./dt;

ddt = year(2:nt-1) - year(1:nt-2);
dd_lowmid = d_lowmid_dt(2:nt-1) - d_lowmid_dt(1:nt-2);
dd_lowmid_dt = dd_lowmid./ddt;
tmidd = .5*(year(2:nt-1)+year(1:nt-2));

figure(3)
plot(tmidd, dd_lowmid_dt,'o')
xlabel('Time (years)')
ylabel('Derivative of Growth Rates')

title('Devrivative of Population Growth Rate of Low-mid Income Countries')

% 
%e
%log(P) = logP0 + a*t
P= polyfit(year, log(low_country),1);
% a = 0.0261
% P0 = -32.2768 

%f
Low_Growth = exp(P(2)+P(1)*year);
%g
figure(4)
% exponential model
plot(year, Low_Growth./(10^6), '-')
hold on
% actual income
plot(year, low_country./(10^6), '-')
xlabel('Time (years)')
ylabel('Growth Rates (millions of people/year)')
title('Population Growth Rate of Low-income Countries')
% the two plots are pretty close
Low_Country_50 = exp(P(2)+P(1)*50)
% ans = 3.5363e-14


%% Problem2
% a
pop_japan = data(ijapan,:);
figure(5)
plot(year, pop_japan/(10.^6),'-')
xlabel('Time (years)')
ylabel('Population (millions)')
set(gca, 'YScale','log')
title('Population of Japan Over Time')

% b
P= polyfit(year, log(pop_japan),2);
Growth_Japan = exp(P(1)*year.^2 + P(2)*year+P(3));
figure(10)
plot(year, pop_japan/(10.^6),'o')
hold on
plot(year, Growth_Japan/(10.^6), 'o')
xlabel('Time (years)')
ylabel('Population (millions)')
%set(gca, 'YScale','log')
title('Population of Japan Over Time')

%c
%Growth_Japan_2016 =exp(P(1)*2016.^2 + P(2)*2016 + P(3));
%Growth_Japan = exp(P(1)*year.^2 + P(2)*year+P(3));
t= 2050;
Taylor1 = exp(P(1)*t.^2 + P(2).*t + P(3));
Taylor2 = 2.*t.^3*(P(1)).^2 + 3.*(t.^2).*P(1).*P(2) + 2.*t.*P(1).*P(3) + t.*(P(2)).^2 + P(2)*P(3);
Taylor3 = 6.*(P(1).^2).*t.^2 + 6.*P(1).*P(2).*t + 2.*P(1).*P(3) + P(2).^2;

Taylor_term = Taylor1./(10.^6);
Taylor_2_term = (Taylor1 )./(10.^6)+ Taylor2.*(50-16);
Taylor_3_term = (Taylor1)./(10.^6) + Taylor2.*(50-16) + Taylor3.*(50-16).^2.*(1/2);
