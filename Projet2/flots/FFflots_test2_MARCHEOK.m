%% Algorithme de *Ford-Fulkerson* pour les flots
%
% Application à la recherche du plus court chemin du sommet 1 (b) au sommet 2 (a)
% dans un graphe (X,U) modélisé comme un problème de flot maximale
%
% Representation du graphe
%
% n == nombre de sommets
%
% m == nombre d'arcs
%
% Vecteur du nombre de successeurs de chaque sommet : NSUC
%
% Vecteur des successeurs de chaque sommet : SUC
%
%% Initialisations
%NSUC = uint16([3 0 3 1 2 3 2 2]);
NSUC = uint16([2 0 2 1]); % ex2
NSUC = uint16([2 0 2 1]); % ex3
NSUC = uint16([2 0 2 1 2 1]); % ex4
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
%SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 5 2 7 2]);
SUC = uint16([3 4 2 4 2]); % ex2
SUC = uint16([3 4 2 4 2]); % ex3
SUC = uint16([3 5 4 6 2 4 6 2]); % ex4
%
% Vecteur des capacites de chaque arc
%CAPACITE = [inf 1 2 5 3 3 2 0 3 1 3 7 2 1 2 4];
CAPACITE = [1 4 5 2 3]; % ex2
CAPACITE = [3 2 2 2 3]; % ex3
CAPACITE = [3 8 4 2 4 6 3 9]; % ex4
%
% Vecteur de la flot courante phi
phi = zeros(1,m);
%


nb_marque = 0; % nb de sommets marqués
MARQUE = false(1,n); % MARQUE est un vecteur logique
MARQUE(1) = true; % on marque le sommet b == 1 ( a == 2 (b,a) == 1)
%
NONMARQUES = X(~MARQUE); % NONMARQUES contient la liste des sommets non marqués
PUIT_MARQUABLE = true;
%
beta = inf;
%% Algorithme de FF mee
while PUIT_MARQUABLE
    beta = inf;
    MARQUE = false(1,n); % MARQUE est un vecteur logique
    MARQUE(1) = true; % on marque le sommet b == 1 ( a == 2 (b,a) == 1)
    nb_marque = 0
    has_marqued= zeros(1,n);
    while length(find(MARQUE)) > nb_marque
        nb_marque = length(find(MARQUE)) %% Pas ICI !?
        
        MARQUE_new = MARQUE;
        for l = 1:size(X,2) % on parcours tous les sommets
            l
            
            i = X(l)
            if MARQUE(i) % si i est un sommet marqué
                %%AA
                prsuc = sum(NSUC(1:i-1)) + 1;
                for k = prsuc:prsuc+NSUC(i)-1 % k sont les successeurs du marqué
                    i
                    j = SUC(k)  % (i,j) est un arc
                    
                    if get_flot_arc(i,j,phi, NSUC,X,SUC)<get_capacite_arc(i,j,CAPACITE, NSUC,X,SUC) && ~ MARQUE(j) && ~ MARQUE_new(j)
                        MARQUE_new(j)=true; % on marque le successeur j
                        has_marqued(j)=i  % ou has_marqued(k)=l  on dit que c'est i qui a marqué j
                    end
                end
                %AA
            end
            
        end
        MARQUE=MARQUE_new;
    end
    if MARQUE(2)
        [beta, vcycle] = get_chaine(has_marqued, phi,beta, CAPACITE, NSUC,X,SUC);
        phi = phi + beta*vcycle;
    else
        flot_max = get_flot_max(phi, NSUC)
        PUIT_MARQUABLE = false;
    end
end


%% Algorithme de FF FIN mee


