f = @(x)exp(x)-x-6;

initial_guess = 1;
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
   
end