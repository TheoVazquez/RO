%%
% INITIALISATIONS
%
% On nettoie le Workspace
clear all
%
%PARAMETRES Scene
nbremaxobj = 10; % nombre maximal d'objets circulant dans la scene
%
% PARAMETRE pts d'echantillonnage
subd = 2000; % nombre de pts d'echantillonnage
%
% PARAMETRES figure
left = 100; % Parametres de position de la figure de l'image de la scene
bottom = 400;
fagrand = 4; % facteur d'agrandissement de la figure contenant l'image de la scene
%
% PARAMETRES NURBS
% Ordre de la courbe ; deg=order-1
order=4;
% Nombre des points a evaluer
subdiv1=100;
%
% PARAMETRES AG
%--------------------------------------------------------------------------
% utilisation d'un algorithme genetique pour la parameterisation des poids des points de controle
%---------Parametres de l'AG-----------------------------------------------
nb_iter = 5;        % nombre d'iterations
global max_weight;
max_weight=10;      % valeur max des poids
PopulationSize=100; % taille de la population
p_mut=1;            % Probabilite de mutation
modif_rate = 5;     % pourcentage de croisement
%
% PARAMETRES Simulation
pasTemps=0.4;
nbremaxcollision = 5; % nombremaximal de collisions de l'objet 1 avec un autre objet
%