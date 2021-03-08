%(c)
y=2;
x = [-5:0.1:5];
x0 = 1;
a = 8-4.*exp(1/2);
b = 4 - 2.*exp(1/2);
c = -(1/2).*exp(1/2);
f =@(x) 4.*x + 4 - 4.*exp(x./2);
F =@(x) a + b.*(x-x0) + c.*((x-x0).^2);
figure(1)
plot(x,f(x))
hold on
plot(x,F(x))
legend('f(x)','F(x)')
xlabel('x')
grid on

%(d)
x = [-5:0.1:5];
f =@(x) 4.*x + 4 - 4.*exp(x./2);
initial_guess = 1.5;% calculating B
x = initial_guess;
y = f(x); %call function to evaluate initial value
itc = 0; %iteration counter
while(abs(y) > 1e-2) %that means 10^-2; as long as fx hasn't reached 0.01
y = f(x);
dx = 1e-3;
fup = f(x+dx);
fdown = f(x-dx);
dfdx = (fup-fdown)/(2*dx);
dif = -f(x)./dfdx;
x = x+dif;
itc = itc+1;
xi(itc) = x;
yi(itc) = f(x);
end;
% mark 0pts
figure(1)
plot(0,f(0),'r*')
plot(2.5129,f(2.5129),'r*')
legend('f(x)','F(x)','A(0,0)','B(2.5129,0)')