function [H] = second_partial_derivative_test(x,y)
 Z_xx = -(1/2).*sin(x./2) + (1/25).*exp(x./5);
 Z_yy = -cos(y);
 Z_xy =  0;
 H = Z_xx.*Z_yy - Z_xy.^2;