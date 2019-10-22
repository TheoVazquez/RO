

% pour M marqué
    % pour S un successeur de M marquable (ie
    % phi(k)<CAPACITE(i))
        % marquer S
        % beta = min(beta,CAPACITE(k)-phi(k)); % k est la liaison (M,S)
        % vcycle(k) = 1; % on note que la liason (M,S) fait parti du cycle
        
%         
% On part de b pour aller à a
% b = COURANT
% Tant que a != COURANT
%     MARQUE(COURANT) = 1 %on ajoute le courant aux marqués
%     S = un_successeur_de(COURANT)            % Choisir un successeur de COURANT
% S est choisi parmi les sucesseurs qui ont au moins un successeur(ou succ
% de succ...) qui est non marqué, ie il reste un chmin non exploré
%     liason_k = (COURANT, S)                  % La liaison entre COURANT et S
%     vcycle(liaison_k)=1                     % On dit que l'on est passé par la liaison (COURANT,S)
%     alpha = min(alpha, phi_k - capacite_k)  % On met a jour alpha sur ce chemin/cycle
%     COURANT = S                              % Le nouveau COURANT est le successeur

% PB : Comment passer par tous les chemins et ne pas repasser par le même ?


function [boole] = existe_inexplore(sommet)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;
if NSUC(sommet) == 0
    boole = MARQUE(sommet)
else
    for S in successeurs(sommet)
        boole= MARQUE(S) && existe_inexplore(S)
    end
end
end
