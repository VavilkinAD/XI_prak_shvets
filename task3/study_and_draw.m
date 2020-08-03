function study_and_draw(a_21,a_22,delta1,delta2,d1)
%d1 = double(d1)
a_21=subs(a_21,[delta1,delta2],[d1,0]);
a_22=subs(a_22,[delta1,delta2],[d1,0]);

A=[0 1;a_21 a_22];

    if (real(double(eig(A))) < 0) == 1
         fprintf('(%.3f,0) is stable\n',d1)
    else
         fprintf('(%.3f,0) is unstable\n',d1)
    end

end

