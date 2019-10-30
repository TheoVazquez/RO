function V = vecnod(order,npc)
%
% Calcul du vecteur nodal d'une NURBS ayant npc points de contrÃ´le et dont
% l'ordre est order
% La NURBS interpole le point de depart et d'arrivee
total = order + npc;
delta = 1/total;
%
V = delta:delta:1;


% lorsque l'écart entre chaque nœud consécutifs est identique,
%le vecteur est uniforme et la courbe l'utilisant est dite uniforme.
for i = 1:total
    V(i) = (i-order-1)/(total - 2 * order -1)
end


V(1:order)=0;
V(end-order+1:end) = 1;
%Ceci oblige alors la courbe à passer par le premier ainsi que par le dernier point du polygone de contrôle