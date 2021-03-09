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

