% Algorithme de *Ford-Fulkerson* pour les tensions
%

%
%% Algorithme de FF



function [chemincrit, tpscrit, tps] = FFtensions(NSUC,SUC,LONG)
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
% n == nombre de sommets
% m == nombre d'arcs
% Vecteur du nombre de successeurs de chaque sommet : NSUC
% Vecteur des successeurs de chaque sommet : SUC
% Vecteur des longueurs de chaque arc : LONG

%création d'une matrice ANT pour le graphe
ANT = zeros(n,n)-1;
nbsucv = 0; %nombre de succ visiter
for i = 1:n
    for j = 1:NSUC(i)
        ANT(i,SUC(nbsucv + j)) = LONG(nbsucv + j);
    end
    nbsucv = nbsucv + NSUC(i);
end
tpscrit = zeros(1,n);
chemincrit = zeros(n,n) -1;
for sommetActuel = 3:n
     
    for sommetPred = getPred(ANT,sommetActuel)
        %Pour chaque prédecesseur, on fait la somme entre crit du pred et
        %temps entre pred et sommetActuel
        tps = tpscrit(sommetPred) + ANT(sommetPred , sommetActuel);
        if tps >= tpscrit(sommetActuel) 
            %mise a jour
            tpscrit(sommetActuel) = tps;
            %maj de chemin
            disp(["maj de sommet " , sommetActuel])
            for step = 2:n
                %Si l'on doit ajouter un nouveau step au chemin crit du
                %sommet actuel
                if (chemincrit(sommetPred, step) == -1)
                    %Ajout du sommetPred au chemin crit du sommet actuel
                    chemincrit(sommetActuel,step) = sommetActuel;
                    %chemincrit(sommetActuel,:);
                    break
                else
                %Sinon on ajoute le step du chemin pred au fur et à mesure
                    chemincrit(sommetActuel,step) =  chemincrit(sommetPred, step);
                end
            end
        end 
    end 
end
%Calcul du dernier sommet
disp("TRAITEMENT DE 1")
sommetActuel = 1;
ANT;
for sommetPred = getPred(ANT,sommetActuel)
    
    tps = tpscrit(sommetPred) + ANT(sommetPred , sommetActuel);
    if tps >= tpscrit(sommetActuel) 
        disp(["maj de sommet " , sommetActuel])
        tpscrit(sommetActuel) = tps;
        for step = 2:n
            if (chemincrit(sommetPred, step) == -1)
                chemincrit(sommetActuel,step) = sommetActuel;
                break
            else
                chemincrit(sommetActuel,step) =  chemincrit(sommetPred, step);
            end
        end
    end 
end 
tps = tpscrit(1);








% MARQUE = false(1,n);
% MARQUE(2) = true;
% 
% while ~MARQUE(1) 
%     for sommetActuel=2:n 
%         for suc = sum(NSUC(1:sommetActuel+-1)) + 1 : sum(NSUC(1:sommetActuel-1)) + NSUC(sommetActuel)
%            if LONG(suc)+tpscrit(sommetActuel) >tpscrit(suc) 
%               tpscrit(suc) = LONG(suc) ;
%            end
%            MARQUE(suc) = true;
%         end    
%     end
%     
% end




