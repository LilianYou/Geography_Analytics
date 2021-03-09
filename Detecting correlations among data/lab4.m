%%% Question1

data=load('ding-data1.txt');
time = data(:,1);
var1 = data(:,2);
var2 = data(:,3);
var3 = data(:,4);
var4 = data(:,5);

%% 1 Plot all variables together
figure(1)
plot(time,var1)
hold on
plot(time,var2)
hold on
plot(time,var3)
hold on
plot(time,var4)
hold off
xlabel('Time');
ylabel('Variable')
title('Variables Over Time')
legend('Var1','Var2','Var3','Var4');

%% 2 

variabels =['Var1';'Var2';'Var3';'Var4'];
beta=fitlm(data(:,2:4),data(:,5),'ResponseVar',variabels(4,:),'PredictorVars',variabels(1:3,:))
var4pred = 8.4632e-07 + 0.15806*var1 -0.0025624*var2 + 0.1381*var3;
figure(2)
plot(time,var4pred);
hold on
plot(time, var4);
hold off
xlabel('Time');
ylabel('Variable')
title('Variables Over Time')
legend('Var4pred','Var4');

% From regression model, variable1 is the most important in the regression
% model.

%% 3
Coef = corr(var4pred,var4,'Type','Pearson'); %  0.6071

%% 4
N = length(var1);
M=4;
G=zeros(N,M);
G(:,1)=1;
G(:,2)=var1;
G(:,3)=var2;
G(:,4)=var3;
dobs = var4;
mest = (G'*G)\(G'*dobs); %[8.46324810086454e-07;0.158059131079404;-0.00256240349981980;0.138103115976902]

dpre = G*mest;
e = dobs - dpre;
E = e'*e;

var4pred2 = 8.46324810086454e-07 + 0.158059131079404*var1 -0.00256240349981980*var2 + 0.138103115976902*var3;

figure(3)
plot(time,var4pred);
hold on
plot(time,var4pred2);
hold off
xlabel('Time');
ylabel('Variable')
title('Variables Over Time')
legend('Var4pred','Var4');

% The result I get from using data kernel method is the same as the result
% derived from fitlm as showed in figure3 that both lines exactly overlaps.

%%% Question2

%% (1) a. Plot X and Y (vs time)
data2=load('ding-data2.txt');
time2 = data2(:,1);
X = data2(:,2);
Y = data2(:,3);

figure(4);
plot(time2,X);
hold on
plot(time2,Y);
hold off
xlabel('Time');
ylabel('Variable')
title('Variables Over Time')
legend('X','Y');
%  b. build a linear regression model (Y=a+bX)
variabels_x_y =['Var1';'Var2'];
beta_XY =fitlm(X,Y,'ResponseVar',variabels_x_y(2,:),'PredictorVars',variabels_x_y(1,:))

Y = -1.3396e-05 + 0.07136*X;

% c. calculating linear trends of X and Y 
variabels =['Var1';'Var2';'Var3'];
beta_X =fitlm(data2(:,1),data2(:,2),'ResponseVar',variabels(2,:),'PredictorVars',variabels(1,:))
beta_Y =fitlm(data2(:,1),data2(:,3),'ResponseVar',variabels(3,:),'PredictorVars',variabels(1,:))

X_pre = -3904.1 + 1.9555*time2 % linear trends of X changes 19.555 unit/decade
Y_pre = -417.57 + 0.20915*time2 % linear trends of Y changes 2.0915 unit/decade

%% (2)
%a. Remove the linear trends from X and Y
Y_residual = Y_pre - Y;
X_residual = X_pre - X;

%b.  plot the residual parts
figure(5);
plot(time2,X_residual);
hold on
plot(time2,Y_residual);
hold off
xlabel('Time');
ylabel('Variable Residual')
title('Variable Residuals Over Time (Linear)')
legend('X Residual','Y Residual');

% c. calculate the correlation between the two residual time series.
Coef_residual = corr(X_residual,Y_residual,'Type','Pearson'); %  0.7442

% d. Build a linear regression model again for the residual X and Y (Yresidual=a+bXresidual)
variabels_xy =['Var1';'Var2'];
beta_X_Y =fitlm(X_residual,Y_residual,'ResponseVar',variabels_xy(2,:),'PredictorVars',variabels_xy(1,:))

Y_residual = -0.005177 + 0.056779*X_residual ; 
% compare it with the linear regression model we get from 1: Y = -1.3396e-05 + 0.07136*X
% a decreases while b increases

%% (3) Repeat 1 and 2 but using the regressed quadratic trend.
% a. repeat 1 by using the regressed quadratic trend
N = length(time2);
M=3;
G=zeros(N,M);
G(:,1)=1;
G(:,2)=time2;   
G(:,3)=(time2).^2;  

dobs_X = X;
mest_X = (G'*G)\(G'*dobs_X);
X_pre2 = 423648 -426.358*time2 + 0.1073*time2.^2; 

dobs_Y = Y;
mest_Y = (G'*G)\(G'*dobs_Y);
Y_pre2 = 23040 -23.2904*time2 + 0.0059*time2.^2;

%b.repeat 2 by using the regressed quadratic trend
% (i) Remove the quadratic trends from X and Y
X_residual2 = X_pre2 - X;
Y_residual2 = Y_pre2 - Y;

%b.  plot the residual parts
figure(6);
plot(time2,X_residual2);
hold on
plot(time2,Y_residual2);
hold off
xlabel('Time');
ylabel('Variable Residual')
title('Variable Residuals Over Time (Quadratic)')
legend('X Residual','Y Residual');

% c. calculate the correlation between the two residual time series.
Coef_residual2 = corr(X_residual2,Y_residual2,'Type','Pearson'); % 0.7141

% The correlation coefficient of two residual time series is smaller when
% using quadratic trend (0.7141) than using linear regression (0.7442), so
% the quadratic trend is more reasonable to capture the long term change in
% X and Y.


%%% Question 3 Use example2.m

%% 1.Use the example2.m to plot the sum of first 10 Sine terms to reconstruct the square wave
N = 20;
x = [0:100]/100;
f = ones(1,101)*1/2;
ff= zeros(1,101);
for i = 1:2:N
    a = 2/pi/i;
f = f+ a*sin(2*pi*i*x);

end

figure(7)
plot(x,f)
title('Sum of First 10 Sine Terms')

%% 2. Modify example2.m to plot the sum of first 100 Sine terms illustrating 5 full periods of the oscillation of the square wave. (the total time points are still equal to 101).
N = 200;
x = [0:100]/20;
f = ones(1,101)*1/2;
ff= zeros(1,101);
for i = 1:2:N
    a = 2/pi/i;
f = f+ a*sin(2*pi*i*x);

end

figure(8)
plot(x,f)
title('First 100 Sine Terms')