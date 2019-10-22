function [beta,vcycle] = get_chaine(has_marqued,phi, beta, CAPACITE, NSUC,X,SUC)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
vcycle = zeros(1, size(phi, 2))
sommet_courant = 2 ;
has_marqued
while sommet_courant ~= 1
    som_precedt = has_marqued(sommet_courant)
    sommet_courant
    capa_k = get_capacite_arc(has_marqued(sommet_courant),sommet_courant,CAPACITE,NSUC,X,SUC)
    flot_k = get_flot_arc(has_marqued(sommet_courant),sommet_courant,phi, NSUC,X,SUC)
    beta = min(beta,capa_k- flot_k)
    vcycle = maj_vcycle(has_marqued(sommet_courant),sommet_courant,vcycle, NSUC,X,SUC)
    sommet_courant = has_marqued(sommet_courant);
end
vcycle
beta
end

