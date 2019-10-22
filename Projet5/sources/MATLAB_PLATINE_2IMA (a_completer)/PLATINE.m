%% Programme PLATINE V2.0: script de dialogue
% PLATINE : PLAnificateur de Trajectoires d'INterception et d'Evitement
%
% permet de :
% créer/charger une image d'une scène 2D
% créer/détruire les chemins des objets circulant dans cette scène
% définir leurs point de départ et d'arrivée
% calculer leurs chemins de longueur minimale
% définir leurs lois de vitesse sur ces chemins pour déterminer leurs
% trajectoires
% simuler leurs déplacements
% déterminer leurs collisions éventuelles
% calculer leurs temps de parcours en prenant en compte leurs temps de
% réparation
%%
% Une scene 2D est une image numerique composee
% - d'obstacles fixes : reunion de rectangles , cercles et ellipses pleins
% - d'objets mobiles posédant chacun une trajectoire modélisée par une
% courbe NURBS et une loi de vitesse (une trajectoire est un chemin
% paramétré par le temps)
%
% Liste des VARIABLES
% NOMSCENE : Nom de la scene courante
% NOMFIC : Nom du chemin d'acces relatif au fichier contenant la definition de la
%          scene : ['Scenes', NOMSCENE,'.mat']
% nombre_objets : nombre d'objets mobiles dans la scene
%
%% DIALOGUE
disp(' ')
cprintf('*comment',['Bonjour ', getenv('USER'), ' , bienvenu.e dans PLATINE V2.0, votre planificateur de trajectoire !']);
disp (' ');
disp(' ');
%
Initialisation % Initialisation des parametres de PLATINE
%
%%
disp('********************************************');
disp ('Pour travailler sur une scene existante , taper 1');
disp ('Pour creer une scene taper 2');
disp ('Pour terminer taper RETURN');
disp('********************************************');
reponse = input ('Reponse ? ','s');
%
while ( ~strcmp(reponse,'1') && ~strcmp(reponse,'2') && ~isempty(reponse))
    cprintf('red','Reponse incorrecte');
    disp(' ')
    reponse = input ('Reponse ? ','s');
end
if isempty(reponse)
    return
end
%
switch reponse
    case '1'
        cprintf('magenta','Travail sur une scene existante');
        disp(' ');
        NOMFIC = uigetfile('Scenes/*.mat');
        if NOMFIC ~= 0
            % un fichier de nom NOMFIC existe
            NOMSCENE = NOMFIC(1:length(NOMFIC)-4);
            %
            NOMFIC = ['Scenes/' NOMFIC];
            load(NOMFIC);
        else
            return
        end
        %
    case '2'
        cprintf('magenta','Creation d''une scene');
        disp(' ');
        CreateScene3; % Version 1.11
        nombre_objets = 0; % il n'y a pas d'objet mobile
        NOMSCENE = input('Nom de la scene ? ','s');
        if isempty(NOMSCENE)
            return
        end
        NOMFIC = ['Scenes/' NOMSCENE];
        save(NOMFIC,'im','nombre_objets','subd');
    otherwise
        return
end
%
continuer = true;
%
while continuer
    %
    cprintf('blue',['Le nom de la scene courante est : ',NOMSCENE]);
    NOMFIC = ['Scenes/' NOMSCENE];
    disp(' ');
    %
    disp('********************************************');
    disp ('Pour changer de scene courante , taper 0');
    disp ('Pour afficher la scene courante , taper 1');
    disp ('Pour creer une scene , taper 2');
    disp ('Pour sauvegarder la scene courante, taper 11');
    disp ('*')
    disp ('Pour creer une nouvelle trajectoire dans la scene courante , taper 3');
    disp ('Pour changer la loi de vitesse d''une trajectoire , taper 4');
    disp ('Pour detruire une trajectoire dans la scene courante , taper 5');
    disp ('Pour optimiser une trajectoire , taper 7');
    disp ('*')
    disp ('Pour simuler les deplacements dans la scene courante , taper 6');
    disp('*')
    disp('Pour terminer , taper RETURN');
    disp('********************************************');
    reponse = input('Reponse ? ');
    if isempty(reponse)
        return
    end
    %
    switch reponse
        %
        case 0 % Changement de la scene courante
            %
            cprintf('magenta','Changement de scene');
            disp(' ');
            NOMFIC = uigetfile('Scenes/*.mat');
            if NOMFIC ~= 0
                % un fichier de nom NOMFIC existe
                NOMSCENE = NOMFIC(1:length(NOMFIC)-4);
                %
                NOMFIC = ['Scenes/' NOMFIC];
                load(NOMFIC);
            end
        case 11 % Sauvegarder la scene courante dans le dossier "Scenes"
            %        en lui donnant 'SAUV' comme prefixe
            %
            cprintf('magenta','Sauvegarde de la scene courante');
            disp(' ');
            %
            NOMFIC = ['Scenes/SAUV' NOMSCENE '.mat'];
            save(NOMFIC,'im','nombre_objets','subd','T');
        case 2 % Creer une scene
            %
            cprintf('magenta','Creation d''une scene');
            disp(' ');
            %
            CreateScene3; % Version 1.11
            imscene = im; % sauvegarde de im
            % pas de creation de nouveau chemin
            nombre_objets = 0;
            NOMSCENE = input('Nom de la scene ? ','s');
            if ~isempty(NOMSCENE)
                NOMFIC = ['Scenes/' NOMSCENE '.mat'];
                save(NOMFIC,'im','nombre_objets','subd');
            end
            %
        case {1,3}
            %
            % Afficher scene courante : 1
            % OU
            % Creer une nouvelle trajectoire dans la scene courante : 3
            %
            disp(' ');
            cprintf('magenta','Affichage de la scene courante');
            disp(' ');
            %
            % Parametres de position de la figure de l"image de la scene
            nlig = size(im,1);
            ncol = size(im,2);
            width = fagrand * nlig;
            length1 = fagrand * ncol;
            %
            hdepl = figure ('Position',[left,bottom,width,length1]); %creation nouvelle figure
            colormap(jet); % initialisation table couleur
            hdepl.Name = NOMSCENE;
            imagesc(im);
            hold on
            %
            if nombre_objets > 0
                % On affiche les chemins de la scene
                affich_chemins2;
                % On affiche les positions de depart et d'arrivee
                affichage_da;
                %
            end
            if reponse == 3
                % Creer nouvelle trajectoire
                imscene = im;
                nombre_objets = nombre_objets + 1;
                %
                % Creer nouveau chemin
                % Création d'un chemin qui est un segment de droite ou une
                % nurbs.
                type_chemin = input('DROITE ou NURBS ? [D/N] ','s');
                if type_chemin == 'D'
                    cprintf('blue','Le chemin de la nouvelle trajectoire est un segment de DROITE');
                    Chemin_Initial_Droite;
                    exception = false; % Pas d'exception si chemin est D
                    T(nombre_objets).chemin = 'DROITE';
                else
                    cprintf('blue','Le chemin de la nouvelle trajectoire est une NURBS');
                    Chemin_Initial2; %planification offline
                    if ~exception
                        T(nombre_objets).chemin = 'NURBS';
                        T(nombre_objets).nurbs = nurbsf;
                    end
                end
                if ~exception
                    %
                    T(nombre_objets).depart = [idep jdep];
                    T(nombre_objets).arrivee = [iarr jarr];
                    %
                    T(nombre_objets).rayon_min = rho_min;
                    %
                    T(nombre_objets).diametre_robot = diametre_robot;
                    %
                    disp('Donner une couleur au robot en choisissant parmi:');
                    disp('red , blue, cyan, magenta , yellow , black , white, green');
                    couleur = input('Couleur : ','s');
                    T(nombre_objets).couleur = couleur;
                    %
                    % Definir le nombre de fois que le chemin est parcouru dans un
                    % sens puis dans l'autre
                    nbre_rep = input(['Nombre de repetitions du chemin de l''objet ',num2str(nombre_objets),' : ']);
                    T(nombre_objets).nbre_repetition = nbre_rep;
                    %
                    % Creer nouvelle loi de vitesse
                    reponse3 = input ('Vitesse constante ? [Y/N]','s');
                    if reponse3 == 'Y'
                        vitesse = input(['Vitesse de l''objet ',num2str(nombre_objets),' : ']);
                        T(nombre_objets).vitesse = vitesse;
                    else
                        disp('NON IMPLANTE !');
                    end
                    %
                    % Definir la portee de l'objet
                    portee = input(['Portee de l''objet ',num2str(nombre_objets),' : ']);
                    T(nombre_objets).portee = portee;
                    %
                    % Definir le temps de reparation de l'objet
                    temps = input(['Temps de reparation de l''objet ',num2str(nombre_objets),' : ']);
                    T(nombre_objets).temps_repar = temps;
                    %
                    % Sauvegarde de la scene
                    reponse = input('Changement du nom de la scene ? [Y/N] ','s');
                    while reponse == 'Y'
                        NOMSCENE = input('Nouveau nom de la scene : ','s');
                        NOMFIC = ['Scenes/' NOMSCENE '.mat'];
                        if exist(NOMFIC,'file') == 0
                            disp ('OK'); % le fichier n'existe pas deja , c'est bon
                            reponse = 'N';
                        else
                            % le fichier existe deja il faut donner un autre nom
                            disp('le fichier existe deja il faut donner un autre nom');
                        end
                    end
                    save(NOMFIC,'im','nombre_objets','subd','T');
                    %
                end
                %
            end
        case 4 % changer la loi de vitesse d'une trajectoire
            %
            cprintf('magenta','Changer la loi de vitesse d''une trajectoire');
            disp(' ');
            %
            i = input('Numero de l''objet  : ');
            vold = T(i).vitesse;
            disp(['Ancienne vitesse de l''objet ',num2str(i),' : ',num2str(vold)]);
            vnew = input(['Nouvelle vitesse de l''objet ',num2str(i),' : ']);
            T(i).vitesse = vnew;
            save(NOMFIC,'im','nombre_objets','subd','T');
            %
        case 5 % destruction d'une trajectoire dans la scene courante
            %
            cprintf('magenta','Destruction d''une trajectoire');
            disp(' ');
            %
            % Parametres de position de la figure de l"image de la scene
            width = fagrand * size(im,1);
            length1 = fagrand * size(im,2);
            %
            hdepl = figure ('Position',[left,bottom,width,length1]); %creation nouvelle figure
            colormap(jet); % initialisation table couleur
            hdepl.Name = NOMSCENE;
            imagesc(im);
            hold on
            %
            DelTraj;
            %
        case 6 % Simulation
            %
            cprintf('magenta','Simulation');
            disp(' ');
            %
            Simulation4; % execution de la simulation V2.0
            %
        case 7 % Deformation de la trajectoire
            %
            cprintf('magenta','Optimisation de trajectoire');
            disp(' ');
            if exist('Deformation_trajectoire','file') == 2
                %
                Deformation_trajectoire;
            else
                cprintf('red','Le script Deformation_trajectoire n''existe pas !');
            end
            %
        otherwise
            cprintf('red','Reponse incorrecte');
            disp(' ');
    end
    disp(' ');
    if reponse ~= 0
        reponse = input('Continuer ? [Y/N] ','s');
        while (~strcmp(reponse,'Y') && ~strcmp(reponse,'N'))
            cprintf('red','Reponse incorrecte');
            disp(' ')
            reponse = input ('Reponse ? ','s');
        end
        if (reponse == 'N')
            continuer = false;
        end
    end
end