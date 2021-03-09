%%% Lab2 Lily Cheng
%% 1. solve for X
M = [2 -3 -1 4; 2 3 -3 2; 2 -1 -1 -1; 2 -1 2 5];
N = [1; 2; 3; 4];
x = M \ N; x
% x1 = 1.9755; x2 = 0.3627; x3 = 0.8431; x4 = -0.2549

%% 2.
y = 0;

for i = [1:1:20]
    y = y + sum(Function(i))
end

%%3
D = load('ding-data1.txt');
year = D(:,1);
X = D(:,2);
Y = D(:,3);
% (1) calculate the three correlations
r_pearson = corr(X, Y, 'Type', 'Pearson') % key: r_pearson = 0.8266
r_spearman = corr(X, Y, 'Type', 'Spearman') % key: r_spearman = 0.8005
r_kendall = corr(X, Y, 'Type', 'Kendall') % key: r_kendall = 0.6222

% (2) calculate effective sample size
n = length(X);
lag1 = autocorr(X);
lag_1 = lag1(2);
lag2 = autocorr(Y);
lag_2 = lag2(2);
N = n*(1- lag_1*lag_2)/(1+lag_1*lag_2); % N = 28.2254
t = r_pearson * sqrt(N/(1 - r_pearson^2)); % t = 7.8019 If we use effective sample size, we don't need to use n-2 (just use n)
% check the two-tailed T table. t = 7.8019 > 2.048. It's significant.

% (3) use bootstrap to test the significance of Pearson r
rng(0)
rhos1000 = bootstrp(1000, 'corrcoef', X, Y);

c = rhos1000(:,2);
figure(1)
histogram(c) % By observing histogram, the mode falls around 0.8, which means the Pearson r is significant.

%% 4 Load ‘organicmatter_three.mat’ to do the two-sample T-test
clc;
corg = load('organicmatter_three.mat');

figure(2);
histogram(corg1,'FaceColor','b'),hold on
histogram(corg2,'FaceColor','r'),hold off
[h,p,ci,stats] = ttest2(corg1,corg2,0.05) % p = 6.1138e-06, significant. corg1 and corg2 are different.

%% Load ‘organicmatter_five.mat’ to do the two-sample F-test
clc;
corg = load('organicmatter_five.mat');

figure(3);
histogram(corg1,'FaceColor','b'),hold on
histogram(corg2,'FaceColor','r'),hold off

[h,p,ci,stats] = vartest2(corg1,corg2,0.05) % p = 0.3037, there is no difference between corg1 and corg2


