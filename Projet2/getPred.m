%cette fonction liste les prédécesseurs d'un sommet
function [listePred] = getPred(ANT, sommet)
listePred = []; %vecteur des prédécesseurs du sommet som
n=size(ANT,1); %nombre de sommets
for i = 1:n
    if ANT(i,sommet) ~= -1
        listePred = [listePred i]; %liste les antecedants du sommet som
    end
end