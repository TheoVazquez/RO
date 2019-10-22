function [k,car_trouve] = carrefour(i,j,isom,jsom,nbrecar)
%
% EN ENTREE
% nbrecar est le nombre de carrefours
% [isom(1:nbrecar);jsom(1:nbrecar)] sont les coordonnees des carrefours
% (i,j) sont les coordonnees d'un pixel dont on veut savoir si c'est un
% carrefour
%
% EN SORTIE
% k = numero du carrefour si (i,j) est un carrefour
%     donc isom(k) == i et jsom(k) == j
% car_trouve == true si (i,j) est un carrefour
%            == false sinon
%
car_trouve = false;
for k = 1:nbrecar
    if i == isom(k) && j == jsom(k)
        car_trouve = true;
        break;
    end
end
