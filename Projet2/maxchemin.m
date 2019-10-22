% Algorithme de *Ford-Fulkerson* pour les tensions


%ANT : matrice des connexions
%som : numero du sommet en cours
%maxi : le chemin le plus long pour arriver au sommet som
%ind : numero du sommet antecedant ou aller pour trouver le chemin critique

function [maxi, ind] = maxchemin(ANT,som)
ante = []; %vecteur des antécédants du sommet som
n=size(ANT,1); %nombre de sommets
for i = 1:n
    if ANT(i, som) ~= 0
        ante = [ante i]; %liste les antecedants du sommet som
    end
end
if ISEMPTY(ante) %cas de base
    maxi = 0;
    ind = 0;
else
    
[max,indice] = maxchemin(ANT,ante)+ANT(ante,som);
ind = ante(indice);
end





