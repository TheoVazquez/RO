function [coeff_sens, vcycle_maj] = maj_vcycle_REVERSE(sommet1,sommet2,vcycle, NSUC,X,SUC, ANT_matrix)
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
prsuc = sum(NSUC(1:sommet2-1)) + 1
for k = prsuc:prsuc+NSUC(sommet2)-1
    k
    SUC(k)
    if SUC(k) == sommet1
        ind_sommet2 = k
    end    
end
% savoir si le lien entre le sommet est direct ou indirect
if ANT_matrix(sommet1,sommet2)>-1
    coeff_sens=1
else
    coeff_sens=-1
end

if ind_sommet2 == -1
    disp "Pas d arc"
    vcycle_maj = vcycle;
else
    vcycle(ind_sommet2) = 1;
    vcycle_maj = vcycle;
end
coeff_sens = vcycle(ind_sommet2);
end

