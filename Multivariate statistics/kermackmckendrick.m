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

timestep = [1:999];
figure(2);
plot(timestep, m)