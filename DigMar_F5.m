function [eval_out, f_max] = DigMar_F5(eval_countIN,x_in)
%DIGMAR_F5 The test function
%   Detailed explanation goes here
i = size(x_in);
x = x_in;
x(1) = x(1);
x(2) = x(2);
eval_count = eval_countIN;
if (x(1) <= 2.048) && (x(2) <= 2.048)
    if (x(1) >= (-2.048)) && (x(2) >= (-2.048))
        f = 100*(x(1)^2 - x(2))^2 + (1 - x(1))^2;
        eval_count = eval_count + 1;
    else 
        disp("Your x value is outside the bounds");
        f_max = 20;
        eval_out = eval_count + 1;
        return
    end
else
    disp("Your x value is outside the bounds");
    f_max = 20;
    eval_out = eval_count + 1;
    return
end

f_max = f;
eval_out = eval_count;


end

