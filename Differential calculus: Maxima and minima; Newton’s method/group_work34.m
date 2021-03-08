function [c, cprime] = mycostfim(m,x,yobs)

% the linear model
    y =@(m)m*x;

% the cost function
    cost = @(m) (sum(y(m)-yobs).^2);
    c = cost(m);

% the derivative of the cost function
    dm = 1e-3;
    cup = cost(m+dm);
    cdown = cost(m-dm);
    cprime = (cup-cdown)/(2*dm);