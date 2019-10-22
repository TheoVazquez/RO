function [vcycle_maj] = maj_vcycle(sommet1,sommet2,vcycle, NSUC,X,SUC)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ind_sommet2 = -1;
prsuc = sum(NSUC(1:sommet1-1)) + 1
for k = prsuc:prsuc+NSUC(sommet1)-1
    k
    SUC(k)
    if SUC(k) == sommet2
        ind_sommet2 = k
    end    
end
if ind_sommet2 == -1
    disp "Pas d arc"
    vcycle_maj = vcycle;
else
    vcycle(ind_sommet2) = 1;
    vcycle_maj = vcycle;
end

end

