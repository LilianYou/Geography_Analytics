t = [0:100:1000];
A = [535 390 235 166 108 65.7 47.4 28.2 21.9 11.8 8.1];
% plot the data
plot(t, A, 'o')
xlabel('Time (years)')
ylabel('Amount (g)')
title('amount of element remaining')

%calculate dA\dt

nt = length(t);
dA = A(2:nt) - A(1:nt-1);%dA = diff(A)
dt = t(2:nt) - t(1:nt-1);
dAdt=dA./dt;
tmid = .5*(t(2:nt)+t(1:nt-1));

%plot 
figure(2)
plot(tmid,dAdt,'o')
xlabel('Time (years)')
ylabel('dAdt (g/yr)')
title('Derivative')