function [k,som_trouve] = sommet(i,j,isom,jsom)
som_trouve = false;
for k = 1:size(isom,2)
    if i == isom(k) && j == jsom(k)
        som_trouve = true;
        break;
    else
        if isom(k)== 0 && jsom(k) == 0
        break;
        end
    end
end