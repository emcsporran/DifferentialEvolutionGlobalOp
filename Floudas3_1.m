function [eval_out, f_max] = Floudas3_1(eval_countIN,x_in)
%FLOUDAS3_1 The test function
%   A linear objective function with inequality constraints, 3 of which are
% non convex.
% 
% Best known solution
% x* = [579.31, 1359.97, 5109.97, 182.02, 295.6, 217.98, 286.42, 395.60]
% f(x*) = 7049.25

x = x_in;
eval_count = eval_countIN;
f = 0;
t1 = (x(1) >= 100) && (x(1) <= 10000);
a1 = (x(2) >= 1000) && (x(2) <= 10000) && (x(3) >= 1000) && (x(3) <= 10000);
b1 = (x(4) >= 10) && (x(4) <= 1000) && (x(5) >= 10) && (x(5) <= 1000)...
     && (x(6) >= 10) && (x(6) <= 1000) && (x(7) >= 10) && (x(7) <= 1000)...
     && (x(8) >= 10) && (x(8) <= 1000);
disp(a1);
disp(b1);
disp(t1);
con1 = 0.0025*(x(4) + x(6)) - 1;
con2 = 0.0025*(-x(4) + x(5) + x(7)) - 1;
con3 = 0.01*(-x(5) + x(8)) - 1;
con4 = 100*x(1) - (x(1)*x(6)) + 833.33252*(x(4)) - 83333.333;
con5 = (x(2)*x(4)) - (x(2)*x(7)) - 1250*(x(4)) + 1250*(x(5));
con6 = (x(3)*x(5)) - (x(3)*x(8)) - 2500*(x(5)) + 125000;
con = (con1 <= 0)&&(con2 <= 0)&&(con3 <= 0)&&(con4 <= 0)&&(con5 <= 0)&&(con6 <= 0);


if t1
    if a1
        if b1
            if con
                f = x(1) + x(2) + x(3);
                eval_count = eval_count +1;
            end
        end
    end
end

eval_out = eval_count;
f_max = f;

end

