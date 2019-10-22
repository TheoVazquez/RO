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
NSUC = uint16([2 1 2 1]);
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
%SUC = uint16([2 3 4 4 5 6 8 6 7 4 7 8 5 2 7 2]);
SUC = uint16([3 4 1 2 4 2]);
%
% Vecteur des capacites de chaque arc
%CAPACITE = [inf 1 2 5 3 3 2 0 3 1 3 7 2 1 2 4];
CAPACITE = [1 4 inf 5 2 3 ];
%
% Vecteur de la flot courante phi
phi = zeros(1,m);
%
MARQUE = false(1,n); % MARQUE est un vecteur logique
MARQUE(1) = true; % on marque le sommet b == 1 ( a == 2 (b,a) == 1)
%
NONMARQUES = X(~MARQUE); % NONMARQUES contient la liste des sommets non marqués
%
%% Algorithme de FF
while ismember(2,NONMARQUES) % Tant que a == 2 non marqué
    NONMARQUES
    CANDIDATS = false(1,n); % CANDIDATS est un vecteur logique contenant les candidats à
    % être marqués
    %
    %% 1.   MAJ flot courante phi
    beta = inf;
    vcycle = zeros(1,m); % vecteur cocycle des sommets non marqués
    for l=1:size(NONMARQUES,2)
        i = NONMARQUES(l) % i est non marqué
        if NSUC(i) ~= 0 % le nombre de successeurs de i est non nul
            prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
            for k = prsuc:prsuc+NSUC(i)-1
                j = SUC(k) % (i,j) est un arc
                if MARQUE(j)
                    % j est un sommet marqué (et i est nonmarqué donc (i,j)
                    % appartient au cocycle
                    % donc i est candidat à être marqué
                    CANDIDATS(i) = true;
                    beta = min(beta,CAPACITE(k)-phi(k)); % beta > 0
                    vcycle(k) = 1;
                end
            end
        end
    end
    phi = phi + beta*vcycle; %MAJ phi
    %
    %% 2.   Marquer sommets
    liste_candidats_marquage = X(CANDIDATS);
    for l=1:size(liste_candidats_marquage,2)
        i = liste_candidats_marquage(l); % i est non marqué et candidat à être marqué
        if NSUC(i) ~= 0
            % le nombre de successeurs de i est non nul
            prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
            for k = prsuc:prsuc+NSUC(i)-1
                j = SUC(k); % j est successeur du sommet i candidat au marquage
                if MARQUE(j) && phi(k) < CAPACITE(k)
                    % i est non marqué , j est marqué, (i,j) est un arc (de numéro k) , et la
                    % valeur de la flot sur cet arc est égale à la longueur
                    % de l'arc (i,j)
                    % donc on marque i
                    MARQUE(i) = true; % on marque le sommet i
                    NONMARQUES = setdiff(NONMARQUES,i); % on enlève i des sommets non marqués
                end
            end
        end
    end
end
%% 3. Post-traitement : extraction du plus court chemin
i = 1;
prsuc = 1;
nsom = 1;
while i ~= 2
    for k = prsuc:prsuc+NSUC(i)-1
        j = SUC(k);
        if phi(k) < CAPACITE(k)
            nsom = nsom + 1;
            PLUSCOURTCHEMIN(nsom) = j;
            break;
        end
    end
    i=j;
    prsuc = sum(NSUC(1:i-1)) + 1;
end
%
disp (['Plus court chemin : ',num2str(PLUSCOURTCHEMIN(1:nsom))]);
disp (['Longueur du plus court chemin : ', num2str(phi(1))]);