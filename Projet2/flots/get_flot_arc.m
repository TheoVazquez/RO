function [flot_arc1to2] = get_flot_arc(sommet1,sommet2,phi, NSUC,X,SUC)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ind_sommet2 = -1;
prsuc = sum(NSUC(1:sommet1-1)) + 1;
for k = prsuc:prsuc+NSUC(sommet1)-1
    if SUC(k) == sommet2
        ind_sommet2 = k;
    end    
end
if ind_sommet2 == -1
    disp "Pas d arc"
    flot_arc1to2 = -1;
else
    flot_arc1to2 = phi(ind_sommet2);
end

end

