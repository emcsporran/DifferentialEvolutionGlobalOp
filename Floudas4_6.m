function [eval_out, f_max] = Floudas4_6(eval_countIN,x_in,y_in)
%FLOUDAS4_6 The test function
%   Linear objective function with 2 non-linear inequality polynomial
%   constraints. 
%
% Best known solution
% x* = 2.3295
% y* = 3.1783
% f = -5.5079

x = x_in;
y = y_in;
eval_count = eval_countIN;
x_bound = (x >= 0) && (x <= 3);
y_bound = (y >= 0) && (y <= 4);
con1 = 4*x^4 - 32*x^3 + 88*x^2 - 96*x + 36;
con2 = 2*x^4 - 8*x^3 + 8*x^2 +2;
f = 0;
disp(con1);
disp(con2);
if x_bound
    if y_bound
        if (y <= con1)
            if (y <= con2)
                f = - x - y;
                eval_count = eval_count+1;
            end
        end
    end
end

f_max = f;
eval_out = eval_count;

end

