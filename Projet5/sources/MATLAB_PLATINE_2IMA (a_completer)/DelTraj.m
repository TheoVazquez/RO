% DelTraj
%
%NOMSCENE = uigetfile('Scenes/*.mat');
%NOMFIC = ['Scenes/' NOMSCENE];
%load(NOMFIC);
%
affich_chemins2;
%
coulobjdel = input('Couleur de l''objet a detruire: red , blue, cyan, magenta , yellow , black , white, or green ? ','s');
nocc = 0;
index = [];
for i=1:nombre_objets
    if length(coulobjdel) == length(T(i).couleur) && all(T(i).couleur == coulobjdel) % l'objet n°i a-t-il la couleur coulobjdel
        nocc = nocc + 1;
        index = [index i];
    end
end
% Si l'objet 1 doit être detruit on le détruit avec tous les autres objets
switch nocc
    case 0
        disp(['Un objet de cette couleur: ',coulobjdel,' n''existe pas dans la scene !']);
    case 1
        % on supprime l'objet nocc et tous les autres objets si index(1) == 1
        if index(1) == 1
            nombre_objets = 0;
            save(NOMFIC,'im','nombre_objets','subd');
        else
            % l'objet 1 n'est pas supprime; on ne supprime que l'objet index(1)
            T = [T(1:index-1) T(index+1:end)];
            nombre_objets = nombre_objets - 1;
            save(NOMFIC,'im','nombre_objets','subd','T');
        end
    otherwise
        disp('Plusieurs objets ont cette couleur !');
end