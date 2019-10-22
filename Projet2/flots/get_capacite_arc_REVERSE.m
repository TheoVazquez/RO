function [capa_arc1to2] = get_capacite_arc(sommet1,sommet2,CAPACITE, NSUC,X,SUC)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
ind_sommet2 = -1;
prsuc = sum(NSUC(1:sommet1-1)) + 1
ba=prsuc:prsuc+NSUC(sommet1)-1
for k = prsuc:prsuc+NSUC(sommet1)-1
    if SUC(k) == sommet2
        ind_sommet2 = k;
    end    
end
prsuc = sum(NSUC(1:sommet2-1)) + 1
ba=prsuc:prsuc+NSUC(sommet2)-1
for k = prsuc:prsuc+NSUC(sommet2)-1
    if SUC(k) == sommet1
        ind_sommet2 = k;
    end    
end
if ind_sommet2 == -1
    disp "Pas d arc"
    capa_arc1to2 = -1;
else
    capa_arc1to2 = CAPACITE(ind_sommet2);
end
end

