% open U.S. survival curve data
fid = fopen('us_survival_data_2013.txt');
f = textscan(fid,'%s%s%f%f%f%f%f%f%f%f','HeaderLines',2,...
    'Delimiter',',');
fclose(fid);

% numbers for 2013
lx_f = f{3}; % survivorship curve for females in 2013 (number of people
             % surviving to the beginning of that age interval)
lx_m = f{4}; % survivorship curve for males in 2013

%% Question1
% integration, male
dx =5;
b = 105;
a =0;
xb = [0:dx:b];
xa = [0:dx:a];
nxb = length(xb);
nxa = length(xa);
%male
ya_m = lx_m(2.*(xb./dx)+1);
y_int_0_b_m = cumsum(lx_m(2.*(xb./dx)+1).*dx);
%female
ya_f = lx_f(2.*(xb./dx)+1);% population value at age n for females
y_int_0_b_f = cumsum(lx_f(2.*(xb./dx)+1).*dx);

% integral
%male
e_m = abs(sum(lx_m(2.*(xb./dx)+1).*dx)-y_int_0_b_m)./ya_m;

%female
e_f = abs(sum(lx_f(2.*(xb./dx)+1).*dx)-y_int_0_b_f)./ya_f;


% 1(a)
% plot 
figure(1)
plot(xb,e_m,'-o')
hold on
plot(xb,e_f,'-o')
xlabel('Age (years)');
ylabel('Life Expectancy (years)');
title('Life Expectancy for Males and Females');
legend('male','female');
hold on
x = [1:105];
g(x) = x;
plot(x, g(x))

%1(b)
%in the plot, male 40, female 42

%% Problem2
% (a)
xb_0 = [0:dx:b-dx];
difyb_m = lx_m(2.*(xb(2:22)./dx)+1)-lx_m(2.*(xb(1:21)./dx)+1); % male
d_b_m = -((lx_m(1)).^(-1)).*(difyb_m./dx);% male
difyb_f = lx_f(2.*(xb(2:22)./dx)+1)-lx_f(2.*(xb(1:21)./dx)+1); %female
d_b_f = -((lx_f(1)).^(-1)).*(difyb_f./dx);% female
% plot 
figure(2)
plot(xb_0,d_b_m,'o-');
hold on
plot(xb_0,d_b_f,'o-');
xlabel('Age(years)');
ylabel('Probability of Death (log scale)');
title('Probability of Death in Different Age');
legend('male','female');
set(gca, 'YScale','log')
% (b) calculate the area underneath the curve
% integration

y_int_0_b_m = sum((d_b_m(1:nxb-1)).*dx);
y_int_0_b_f = sum((d_b_f(1:nxb-1)).*dx);
% physical intepretation: summation of the rate of the variation of
% probability of death at different ages for males (females)

% (c)
% most probable age of death for males (or females) is 90
%% problem3
%a
u_a_m = d_b_m./lx_m(2.*(xb(1:21)./dx)+1);
u_a_f = d_b_f./lx_f(2.*(xb(1:21)./dx)+1);
figure(3)
plot(xb_0,u_a_m,'o-');
hold on
plot(xb_0,u_a_f,'o-');
xlabel('Age(years)');
ylabel('Force of Mortality (log scale)');
title('Force of Mortality in Different Ages');
legend('male','female');
set(gca, 'YScale','log')
%b
u_d_m = abs(u_a_m - u_a_f)./u_a_m;
u_d_f = abs(u_a_m - u_a_f)./u_a_f;
figure(4)
plot(xb_0,u_d_m,'o-');
hold on
plot(xb_0,u_d_f,'o-');
xlabel('Age(years)');
ylabel('Gender Difference of Force of Mortality');
title('Gender Difference of Force of Mortality in Different Ages');
legend('male','female');

% relative difference peaks at the age 25
%% 4
%a
C_m = exp(-cumsum(dx./e_m(1:21)));
C_f = exp(-cumsum(dx./e_f(1:21)));
figure(5)
plot(xb_0,C_m,'o-');
hold on
plot(xb_0,C_f,'o-');
xlabel('Age a (years)');
ylabel('Proportion of Population');
title('Proportion of Population Age a and Older');
legend('male','female');

%b female around 37, male around 35
%c female  24; male  21