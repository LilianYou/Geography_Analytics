depth = [100, 250,650,1000,1800, 2350,3500,5000];%depth (m)
flux = [5.8166, 2.4736, 1.4481, 1.0013, 0.2982, 0.4126, 0.2739, 0.2897];%(mgC/m^2/d)

yobs = flux;
x = depth;

Zo = 100;
F(Zo) = 5.8166;
y = @(b)(F(Zo).*((x/Zo).^(-b))); % model
% the cost function
cost = @(b) (sum(y(b)-yobs).^2);

initial_guess = 2.1;
b = initial_guess;
c = cost(b); %call function to evaluate initial value
itc = 0; %iteration counter
while(abs(c) > 1e-2) %that means 10^-2; as long as fx hasn't reached 0.01
    c = cost(b);
    db = 1e-3;
    cup = cost(b+db);
    cdown = cost(b-db);
    dfdb = (cup-cdown)/(2*db);
    
    dif = -cost(b)./dfdb;
    b = b+dif;
    
    itc = itc+1;
    
    bi(itc) = b;
    ci(itc) = cost(b);
    dfdbi(itc) = (cost(b+db)-cost(b-db))./(2.*db);
    
    c = cost(b);
   
end;
% bimin = 0.8333 ci = 0.0031 b = 0.1

% bimin = 0.8326 ci = 0 b = 2.1

figure(3);
subplot(2,1,1);
plot(bi,ci,'o');
xlabel('b value');
ylabel('cost function value');
hold on
subplot(2,1,2);
plot(bi,dfdbi,'o');
xlabel('b value');
ylabel('derivative of the cost function')

%(e)
figure(4);
subplot(2,1,2);
plot(bi,ci,'-');
xlabel('b value');
ylabel('cost function value');