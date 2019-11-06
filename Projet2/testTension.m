%% TEST%%
% Initialisations
NSUC = uint16([0 3 1 3 2 2 3 2 1 1 1]);
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([3 4 5 6 6 7 8 8 10 9 11 9 10 11 9 11 1 1 1]);
%
% Vecteur des longueurs de chaque arc
LONG = [5 0 3 16 14 14 14 20 10 8 8 18 18 18 25 25 15 17 10];

[chemincrit, tpscrit, tps] = FFtensions(NSUC,SUC,LONG)

