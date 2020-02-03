function [M] = DigMar_F8(eval_countIN,x_in)
%DIGMAR_F8 The test function
%   Detailed explanation goes here
t = (1:1:10);
x(t) = x_in;
eval_count = eval_countIN;

for t = (1:1:10)
    g = size(t);
    h = size(t);
    if (x(t) <= 600)
        if (x(t) >= (-600))
            g(t) = (x(t)^2)/4000;
            h(t) = sqrt(t)*sin((x(t))/(sqrt(t)));
        else
            disp("Your x value is outside the bounds");
            f_max = 20;
            eval_out = eval_count+1;
            M = [f_max, eval_out];
            return
        end
    else
        disp("Your x value is outside the bounds");
        f_max = 20;
        eval_out = eval_count+1;
        M = [f_max, eval_out];
        return
    end
end

g_final = sum(g,'all');
h_final = prod(h,'all');
disp(g_final);
disp(h_final);
f = 1 + g_final - h_final;
eval_count = eval_count + 1;
f_max = f;
eval_out = eval_count;
M = [f_max, eval_out];

end

