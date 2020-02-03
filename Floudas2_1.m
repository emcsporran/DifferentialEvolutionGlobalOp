function [eval_out, f_max] = Floudas2_1(eval_countIN,x_in)
%FLOUDAS2_1 The test function
%   Non-convex quadratic function
%
% Best solution (global solution)
% x* = [1, 1, 0, 1, 0]
% f(x*) = -17

x = x_in;
test = 20*x(1) + 12*x(2) + 11*x(3) + 7*x(4) + 4*x(5); % constraint
eval_count = eval_countIN;
Q = 100 * eye(5);
c = [42,44,45,47,47.5];
if (test <= 40)  % constraint
    if (0 <= x)    % lower bound
        if (x <= 1)  % upper bound
            %l = (Q.*x)*0.5;
            a = mtimes((x.'),Q);
            l = dot(a,x)*0.5;
            b = dot((c.'),x);
            f = (b - l);  % objective function oriented to maximize
            eval_count = eval_count + 1;
        else
            f = 1000000;
        end
    else
        f = 1000000;
    end
else 
    f = 1000000;
end
eval_out = eval_count;
f_max = f;

%X_OUT = [eval_count, f];
end

