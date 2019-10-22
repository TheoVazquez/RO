function V = vecnod(order,npc)
%
% Calcul du vecteur nodal d'une NURBS ayant npc points de contrôle et dont
% l'ordre est order
% La NURBS interpole le point de depart et d'arrivee
total = order + npc;
delta = 1/total;
%
V = delta:delta:1;
V(1:order)=0;
V(end-order+1:end) = 1;
