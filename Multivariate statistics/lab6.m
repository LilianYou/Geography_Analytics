%%% Question1
%%1)starting from the start point on the left

dt=0.01;        % time step
g=9.81;         % gravity
L=1.0;          % pendulum length

% initial condition
theta= -0.5;      % angle
thetaPrime=0;   % angular velocity

% simulation loop
for t=0:dt:5
    thetaBis=-g/L*sin(theta);
    thetaPrime=thetaPrime+dt*thetaBis;
    theta=theta+dt*thetaPrime;
    plot([0 cos(theta-pi/2)],[0 sin(theta-pi/2)]);
    xlim([-1 1]);
    ylim([-1 0]);
    xlabel('x');
    ylabel('y');
    pause(0.01);
end

%% 2) simulate a swing of the pendulum on the Moon

dt=0.01;        % time step
g=1.62;         % gravity of moon
L=1.0;          % pendulum length

% initial condition
theta=0.5;      % angle
thetaPrime=0;   % angular velocity

% simulation loop
for t=0:dt:5
    thetaBis=-g/L*sin(theta);
    thetaPrime=thetaPrime+dt*thetaBis;
    theta=theta+dt*thetaPrime;
    plot([0 cos(theta-pi/2)],[0 sin(theta-pi/2)]);
    xlim([-1 1]);
    ylim([-1 0]);
    xlabel('x');
    ylabel('y');
    pause(0.01);
end

% It run slower than its swing on Earth.


%%% Question2
%% 1) the swing is very periodic and regular

clc                        %---------------------------------------------------------------------------------------------------%
clear                      % 
                           %                                                                                                   %                                              %                                                                             
                           % parameters:                                                                                       % 
                           % th1(1) :         the angle of the top mass of the first double pendulum                           %                                                            
                           % th2(1) :         the angle of the bottom mass of the first double pendulum                        %                                                          
dt=0.01;                   % thd1(1):         the speed of the top mass of the first double pendulum                           %                                                                    
T=10;                      % thd2(1):         the speed of the bottom mass of the first double pendulum                        %                                                                     
N=int16(T/dt);                                    %                                                                     
th1=zeros(N,1);                                  %                                                                      
                         
th2=zeros(N,1);                                  %                                                                       
thd1=zeros(N,1);           %                                            \                                                      %
thd2=zeros(N,1);           %                                              \                                                    %
         %                                               \                                                   %
thdd1=zeros(N,1);          %                                                \                                                  %
        %                                                 \                                                 %
thdd2=zeros(N,1);          %                                                  \                                                %
        %                                                   \                                               %
X1=zeros(N,1);             %                                                   ooo                                             %
Y1=zeros(N,1);             %                                                  o O o                                            %
          %                                                       \                                           %    
X2=zeros(N,1);             %                                                          \                                        %       
Y2=zeros(N,1);             %                                                             \                                     %           
            %                                                                   \                               %          
                           %                                                                      \                            %           
                           %                                                                         \                         %          
figure;                    %                                                                            \                      %    
hold off;                  %                                                                             ooo                   %           
                           %                                                                            o O o                  %    
th1(1)=pi/8;               %                                                                             ooo                   %
             %                                                                                                   %
th2(1)=pi/8;            %---------------------------------------------------------------------------------------------------%  

thd1(1)=0;

thd2(1)=0;

g=10;

A=-2*g*sin(th1(1))-sin(th1(1)-th2(1))*thd2(1)^2;

B=-g*sin(th2(1))+sin(th1(1)-th2(1))*thd1(1)^2;

thdd1(1)=(A-B*cos(th1(1)-th2(1)))/(2-(cos(th1(1)-th2(1)))^2);
thdd2(1)=B-cos(th1(1)-th2(1))*thdd1(1);

X1(1)=sin(th1(1));
Y1(1)=cos(th1(1));

X2(1)=sin(th1(1))+sin(th2(1));
Y2(1)=cos(th1(1))+cos(th2(1));


for i=2:N
    thd1(i)=thd1(i-1)+dt*thdd1(i-1);
    
    thd2(i)=thd2(i-1)+dt*thdd2(i-1);
    
    th1(i)=th1(i-1)+dt*thd1(i);
   
    th2(i)=th2(i-1)+dt*thd2(i);
    
    A=-2*g*sin(th1(i))-sin(th1(i)-th2(i))*thd2(i)^2;
    
    B=-g*sin(th2(i))+sin(th1(i)-th2(i))*thd1(i)^2;
    
    thdd1(i)=(A-B*cos(th1(i)-th2(i)))/(2-(cos(th1(i)-th2(i)))^2);
    
    thdd2(i)=B-cos(th1(i)-th2(i))*thdd1(i);
  
    X1(i)=sin(th1(i));
   
    Y1(i)=cos(th1(i));
   
    X2(i)=sin(th1(i))+sin(th2(i));
  
    Y2(i)=cos(th1(i))+cos(th2(i));
  
    plot([0, X1(i), X2(i)], [0, -Y1(i), -Y2(i)],'-o');
    hold on
  
    axis([-2 2 -2 2]);
    title(['t = ', num2str(double(i)*dt, '% 5.3f'), ' s']);
    hold on
    plot(X2(1:i), -Y2(1:i), 'r');
    
    hold off
    drawnow;
end
 %% 2) the swing stays in a very chaotic manner
 
clc                        %---------------------------------------------------------------------------------------------------%
clear                      % 
                           %                                                                                                   %                                              %                                                                             
                           % parameters:                                                                                       % 
                           % th1(1) :         the angle of the top mass of the first double pendulum                           %                                                            
                           % th2(1) :         the angle of the bottom mass of the first double pendulum                        %                                                          
dt=0.01;                   % thd1(1):         the speed of the top mass of the first double pendulum                           %                                                                    
T=10;                      % thd2(1):         the speed of the bottom mass of the first double pendulum                        %                                                                     
N=int16(T/dt);                                    %                                                                     
th1=zeros(N,1);                                  %                                                                      
                         
th2=zeros(N,1);                                  %                                                                       
thd1=zeros(N,1);           %                                            \                                                      %
thd2=zeros(N,1);           %                                              \                                                    %
         %                                               \                                                   %
thdd1=zeros(N,1);          %                                                \                                                  %
        %                                                 \                                                 %
thdd2=zeros(N,1);          %                                                  \                                                %
        %                                                   \                                               %
X1=zeros(N,1);             %                                                   ooo                                             %
Y1=zeros(N,1);             %                                                  o O o                                            %
          %                                                       \                                           %    
X2=zeros(N,1);             %                                                          \                                        %       
Y2=zeros(N,1);             %                                                             \                                     %           
            %                                                                   \                               %          
                           %                                                                      \                            %           
                           %                                                                         \                         %          
figure;                    %                                                                            \                      %    
hold off;                  %                                                                             ooo                   %           
                           %                                                                            o O o                  %    
th1(1)=pi/2;               %                                                                             ooo                   %
             %                                                                                                   %
th2(1)=pi + 0.2;            %---------------------------------------------------------------------------------------------------%  

thd1(1)=0;

thd2(1)=0;

g=10;

A=-2*g*sin(th1(1))-sin(th1(1)-th2(1))*thd2(1)^2;

B=-g*sin(th2(1))+sin(th1(1)-th2(1))*thd1(1)^2;

thdd1(1)=(A-B*cos(th1(1)-th2(1)))/(2-(cos(th1(1)-th2(1)))^2);
thdd2(1)=B-cos(th1(1)-th2(1))*thdd1(1);

X1(1)=sin(th1(1));
Y1(1)=cos(th1(1));

X2(1)=sin(th1(1))+sin(th2(1));
Y2(1)=cos(th1(1))+cos(th2(1));


for i=2:N
    thd1(i)=thd1(i-1)+dt*thdd1(i-1);
    
    thd2(i)=thd2(i-1)+dt*thdd2(i-1);
    
    th1(i)=th1(i-1)+dt*thd1(i);
   
    th2(i)=th2(i-1)+dt*thd2(i);
    
    A=-2*g*sin(th1(i))-sin(th1(i)-th2(i))*thd2(i)^2;
    
    B=-g*sin(th2(i))+sin(th1(i)-th2(i))*thd1(i)^2;
    
    thdd1(i)=(A-B*cos(th1(i)-th2(i)))/(2-(cos(th1(i)-th2(i)))^2);
    
    thdd2(i)=B-cos(th1(i)-th2(i))*thdd1(i);
  
    X1(i)=sin(th1(i));
   
    Y1(i)=cos(th1(i));
   
    X2(i)=sin(th1(i))+sin(th2(i));
  
    Y2(i)=cos(th1(i))+cos(th2(i));
  
    plot([0, X1(i), X2(i)], [0, -Y1(i), -Y2(i)],'-o');
    hold on
  
    axis([-2 2 -2 2]);
    title(['t = ', num2str(double(i)*dt, '% 5.3f'), ' s']);
    hold on
    plot(X2(1:i), -Y2(1:i), 'r');
    
    hold off
    drawnow;
end

%%% Question3

% timestep
dt=0.001;
% iterations
iter=5000;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
x(1)=1; y(1)=1; z(1)=40; t(1)=0; % starting point
sigma=10; r=17; b=8/3;

for i=2:iter
    dx=sigma*(y(i-1)-x(i-1));
    dy=r*x(i-1)-y(i-1)-x(i-1)*z(i-1);
    dz=x(i-1)*y(i-1)-b*z(i-1);
    x(i)=x(i-1)+dt*dx;
    y(i)=y(i-1)+dt*dy;
    z(i)=z(i-1)+dt*dz;
    t(i)=t(i-1)+dt;
    
    plot3(x,y,z);
    pause(0.001);
    xlabel('x');
    ylabel('y');
end

% When r = 17, it's the smallest value for two strange attractors state. When r =
% 16, it's the biggest value for one attractor state. So, I will say 
% 17 is the critical value.

 
 %%% Question4
 
 clear;

x(1) = 5;
y(1) = 5;

alpha = 1.0;
beta = 1.0;
gamma = 1.0;
delta = 1.0;

dt = 0.01;

for t = 2:5000
    dx = x(t-1) * (alpha - beta * y(t-1));
    dy = - y(t-1) * (gamma - delta * x(t-1));
    x(t) = x(t-1) + dt*dx;
    y(t) = y(t-1) + dt*dy;
end



%plot(x,y);

%%1 
% 1) plot the changes of x and y against time
figure(1)
plot(x, 'r');
hold on;
plot(y, 'g');

% 2) a phase plot between changes of x and y
figure(2)
plot(x, y);
title('Changes of x and y')

%%2 I think the reason for population increase is because of natural
%%selection that the prey and predators with stronger surviving ability
%%remained and pass their gene with stronger surviving characteristics to
%%the next generation. Therefore, their offsprings live longer and longer.


%%% Question5
% Based on the following K-M model. Please plot a scatter plot between the
% initial number of infected population (I) against the maximum number that
% the infected population (I) could reach within 300 time steps.
clear;

s(1) = 1;
i(1) = 999;
r(1) = 0;
m = [];

for k = 1:999
    
    
    beta = 0.0001;
    gamma = 0.01;

    dt = 1;

    for t = 2:300
        ds = - beta * i(t-1) * s(t-1);
        di = beta * i(t-1) * s(t-1) - gamma * i(t-1);
        dr = gamma * i(t-1);
        s(t) = s(t-1) + dt*ds;
        i(t) = i(t-1) + dt*di;
        r(t) = r(t-1) + dt*dr;
    end
    
    m = [m max(i)];
 
    i(1)= k + 1;
    s(1) = 1000 - i(1);
   
end




figure(1)
plot(s, 'b');
hold on;
plot(i, 'r');
plot(r, 'g');

istep = [1:999];
figure(2);
plot(istep, m)
xlabel('Initial Number of Infected Population (I)');
ylabel('the Maximum Number that the Infected Population (I) Could Reach within 300 Time Steps');
% Please see figure(2) above