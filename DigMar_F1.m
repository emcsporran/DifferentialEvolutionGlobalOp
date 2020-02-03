function [eval_out, f_max] = DigMar_F1(eval_countIN,x_in)
%DIGMAR_F1 The test function
%   Unimodal function, only containing one optimum point.
%   Minimizing
x = x_in;
x1 = x(1);
x2 = x(2);
eval_count = eval_countIN;
if (x1 <= 5.12)&&(x2 <= 5.12)
    if (x1 >= (-5.12))&&(x2 >= (-5.12))
        f = -(x1^2+x2^2);
        eval_count = eval_count + 1;
    else
        %disp("Your x value is outside the bounds");
        f_max = 1000;
        eval_out = eval_count+1;
        return
    end
else
    %disp("Your x value is outside the bounds");
    f_max = 1000;
    eval_out = eval_count+1;
    return
end


f_max = f;
eval_out = eval_count;

end

