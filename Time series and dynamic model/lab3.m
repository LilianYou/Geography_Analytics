%%% Lab3  Lily Cheng
%% Question1

line = load('linedata01.txt');
v1 = line(:,1);
v2 = line(:,2);

% 1st order polynomial
p1 = polyfit(v1,v2,1)    % p =  1.2474    0.4631 
x = [-15:15];
y1 = 0.4631 + 1.2474*x;
n = length(v2); %n = 11
figure(1)
subplot(2,2,1)
plot(v1,v2)
hold on
plot(x,y1)
title('1st order')

% 2nd order polynomial
p2 = polyfit(v1,v2,2)    % p =  0.0068    1.2625    0.2787 
x = [-15:15];
y2 = 0.2787 + 1.2625*x + 0.0068*x.^2;

subplot(2,2,2)
plot(v1,v2)
hold on
plot(x,y2)
title('2nd order')

% 3rd order polynomial
p3 = polyfit(v1,v2,3)    % p =  -0.0079   -0.0142    1.7314    0.4579
x = [-15:15];
y3 = 0.4579 + 1.7314*x - 0.0142*x.^2 - 0.0079*x.^3;

subplot(2,2,3)
plot(v1,v2)
hold on
plot(x,y3)
title('3rd order')

% 4th order polynomial
p4 = polyfit(v1,v2,4)    % p =   -0.0016   -0.0132    0.1044    1.8881   -0.2588
x = [-15:15];
y4 = -0.2588 + 1.8881*x + 0.1044*x.^2 - 0.0132*x.^3 -0.0016*x.^4;

subplot(2,2,4)
plot(v1,v2)
hold on
plot(x,y4)
title('4th order')

% calculating adjusted R square
rds1 = sum((0.4631 + 1.2474*v1-v2).^2); % rds1 = 72.0506
r1_square = 1- rds1/sum((v2-mean(v2)).^2); % r1_square = 0.8681
adjusted_r1_square = 1 - [(1-r1_square.^2)*(n-1)/(n - 1 - 1)] %  0.7262

rds2 = sum((0.2787 + 1.2625*v1 + 0.0068*v1.^2-v2).^2) %rds2 = 71.5855
r2_square = 1- rds2/sum((v2-mean(v2)).^2); %r2_square = 0.8689
adjusted_r2_square = 1 - [(1-r2_square.^2)*(n-1)/(n - 2 - 1)] % 0.6938

rds3 = sum((0.4579 + 1.7314*v1 - 0.0142*v1.^2 - 0.0079*v1.^3-v2).^2) % rds3 = 60.7261
r3_square = 1- rds3/sum((v2-mean(v2)).^2) % r3_square = 0.8888
adjusted_r3_square = 1 - [(1-r3_square.^2)*(n-1)/(n - 3 - 1)] % 0.7000

rds4 = sum((-0.2588 + 1.8881*v1 + 0.1044*v1.^2 - 0.0132*v1.^3 -0.0016*v1.^4-v2).^2) % rds4 = 50.6048
r4_square = 1- rds4/sum((v2-mean(v2)).^2) % r4_square = 0.9073
adjusted_r4_square = 1 - [(1-r4_square.^2)*(n-1)/(n - 4 - 1)] % 0.7055

% Because R square is biased that it doesn't consider the influence of the number of terms in my model, I use adjusted R square to tell if I included too many terms in my model compared with the number of observations. Because if that (overfitting) happens, the regression model becomes tailored to fit the quirks and random noise in my specific data sample rather than reflecting the overall population. Based on the criteria of getting the highest adjusted R square, the 1st
% line has the highest adjusted R square so it best fits the observation.
% In terms of overfitting, the rank of the value of R square is: 
% r1_square <  r2_square <  r3_square <  r4_square
% compare with the rank of the value of adjusted R square, which is:
% adjusted_r1_square > adjusted_r4_square > adjusted_r3_square > adjusted_r2_square
% In this case, as the 1st line is the best fit and the least terms,
% overfitting occurs in all the other 3 lines.

%% Question2
% a) when using 1+x+ x2
N = length(v1);
M=3;
G=zeros(N,M);
G(:,1)=1;
G(:,2)=v1;
G(:,3)=v1.^2;
dobs = v2;
mest = (G'*G)\(G'*dobs); %mest = [0.2787, 1.2625, 0.0068]
%y1 = 0.2787 + 1.2625*x + 0.0068*x.^2;

dpre = G*mest;
e = dobs - dpre;
E = e'*e; % E = [71.5854628182454]


figure(2)
subplot(2,1,1)
plot(v1,v2)
hold on
plot(v1,dpre)
title('1+x+ x.^2')


% b) when using 1+x+exp(x)
F=zeros(N,M);
F(:,1)=1;
F(:,2)=v1;
F(:,3)=exp(v1);
dobs = v2;
mest_F = (F'*F)\(F'*dobs); 

dpre_F = F*mest_F;
e_F = dobs - dpre_F;
E_F = e_F'*e_F; % E_F = [67.4727548324294]

subplot(2,1,2)
plot(v1,v2)
hold on
plot(v1,dpre_F)
title('1+x+exp(x)')

%  As E > E_F, the smaller the error vector, the better the model fits observations. Replacing x.^2 by exp(x) term helps the fitting.


%%% Ques3 : Modify MatLab script, sample.m, to achieve a better fit to the Black Rock Forest temperature dataset (brf_temp.txt).

% eda04_11
% load Black Rock Forest temperature data

% read the data
Draw=load('brf_temp.txt');
traw=Draw(:,1);
draw=Draw(:,2);
Nraw=length(draw);

% exclude bad data
n = find( (draw~=0) & (draw>-40) & (draw<38) );
t=traw(n);
d=draw(n);

N=length(d);
M=4;

% plot the data
figure(1);
clf;
subplot(3,1,1);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,d,'k-','LineWidth',2);
xlabel('time, days');
ylabel('obs temp, C');

% set up data kernel
Ty=365.25;
G=zeros(N,4);
G(:,1)=1;
G(:,2)=t;
G(:,3)=cos(2*pi*t/Ty);
G(:,4)=sin(2*pi*t/Ty);

% predict data
mest = (G'*G)\(G'*d);
dpre = G*mest;
e = d - dpre;
E = e'*e; % 3.3096e+06
subplot(3,1,2);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,dpre,'k-','LineWidth',2);
xlabel('time, days');
ylabel('pre temp, C')

% plot error
subplot(3,1,3);
set(gca,'LineWidth',2);
hold on;
axis( [0, 5000, -40, 40] );
plot(t,e,'k-','LineWidth',2);
xlabel('time, days');
ylabel('error, C')

%% (1) add one additional term x^2 in the regression model.
M=5;

% set up data kernel
Ty=365.25;
F=zeros(N,M);
F(:,1)=1;
F(:,2)=t;
F(:,3)=cos(2*pi*t/Ty);
F(:,4)=sin(2*pi*t/Ty);
F(:,5)=t.^2;

% predict data
mest_F = (F'*F)\(F'*d);
dpre_F = F*mest_F;
e_F = d - dpre_F;
E_F = e_F'*e_F; % 3.3089e+06

%% (2) add additional periods of Ty/2, where Ty is the period of 1 year, in an attempt to better capture the shape of the (semi) annual variation
M=6;

% set up data kernel
Ty=365.25;
H=zeros(N,M);
H(:,1)=1;
H(:,2)=t;
H(:,3)=cos(2*pi*t/Ty);
H(:,4)=sin(2*pi*t/Ty);
H(:,5)=cos(2*pi*t/(Ty/2));
H(:,6)=sin(2*pi*t/(Ty/2));

% predict data
mest_H = (H'*H)\(H'*d);
dpre_H = H*mest_H;
e_H = d - dpre_H;
E_H = e_H'*e_H; % 3.3085e+06

%% (3) add additional periods of Ty/2 and Ty/3 together.
M=8;

% set up data kernel
Ty=365.25;
I=zeros(N,M);
I(:,1)=1+ Ty/2 + Ty/3;
I(:,2)=t;
I(:,3)=cos(2*pi*t/Ty);
I(:,4)=sin(2*pi*t/Ty);
I(:,5)=cos(2*pi*t/(Ty/2));
I(:,6)=sin(2*pi*t/(Ty/2));
I(:,7)=cos(2*pi*t/(Ty/3));
I(:,8)=sin(2*pi*t/(Ty/3));

% predict data
mest_I = (I'*I)\(I'*d);
dpre_I = I*mest_I;
e_I = d - dpre_I;
E_I = e_I'*e_I; % 3.2917e+06

% By comparing the value of 4 error vectors above, I found that 3)add additional periods of Ty/2 and Ty/3 together
% gets the smallest error vector (= 3.2917e+06) which
% works best to achieve a better fit.



