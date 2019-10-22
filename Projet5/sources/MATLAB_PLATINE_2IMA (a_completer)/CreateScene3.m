% CreateScene3
%
close all
%% INITIALISATION
%
lig = input('*** Donner le nombre de lignes de la scene :','s');
lig= str2double(lig);
nlig=int16(lig);
col= input('*** Donner le nombre de colonnes de la scene :','s');
col= str2double(col);
ncol=int16(col);
%
% Parametres de position de la figure de l"image de la scene
width = fagrand * nlig;
length1 = fagrand * ncol;
%
im= 7 * ones(nlig,ncol,'int16'); % initialisation de im a 7
%
disp('Pour initialiser une scene pleine taper 1');
disp('Pour initialiser une scene vide taper 2');
%
reponse = input ('Reponse ? ','s');
%
while ( ~strcmp(reponse,'1') && ~strcmp(reponse,'2') && ~isempty(reponse))
    cprintf('red','Reponse incorrecte');
    disp(' ')
    reponse = input ('Reponse ? ','s');
end
%
if isempty(reponse)
    return
end
%
switch reponse
    case '1'
    case '2'
        im(3:nlig-2,3:ncol-2) = 1;
end
%
figure ('Name','imscene','Position',[left,bottom,width,length1]); %creation nouvelle figure
colormap(jet); % initialisation table couleur
imagesc(im); % on fait apparaître l'image im de la scene pleine ou vide
%%
continuer = true;
while continuer % boucle infinie
    %
    disp('***')
    disp('Pour tracer un rectangle plein, taper 11');
    disp('Pour tracer un rectangle vide, taper 12');
    disp('Pour tracer un cercle plein, taper 21');
    disp('Pour tracer un cercle vide, taper 22');
    disp('Pour tracer une ellipse pleine, taper 31');
    disp('Pour tracer une ellipse vide, taper 32');
    disp('Pour terminer taper RETURN');
    disp('***')
    %
    reponse = input('Reponse ? ');
    %
     if isempty(reponse)
        figure ('Name','imscene','Position',[left,bottom,width,length1]);
        imagesc(im);
        return
     end
    %
    switch reponse
        case {11,21,31}
            valeur = 7; % on trace des obstacles fixes
        case {12,22,32}
            valeur = 1;
    end
    %
    clear imscene
    hscene = figure ('Name','imscene','Position',[left,bottom,width,length1]); %creation nouvelle figure
    imagesc(im); % on fait apparaître l'image im
    %
    button = 0;
    switch reponse
        case {11,12} % tracer un rectangle vide ou plein
            while button ~= 3 % button == 3 <=> clic droit
                disp ('*** Clic gauche sur un coin du rectangle à creer (si fin creation clic droit) ***');
                [p(1),q(1),button] = ginputc(1,'Color','m');
                if button ~= 3
                    disp ('*** Clic gauche sur un autre coin du rectangle à creer ***');
                    [p(2),q(2)] = ginputc(1,'Color','m');
                    % Get the x and y corner coordinates as integers
                    sp(1) = min(round(p(1)), round(p(2))); %xmin
                    sp(2) = min(round(q(1)), round(q(2))); %ymin
                    sp(3) = max(round(p(1)), round(p(2))); %xmax
                    sp(4) = max(round(q(1)), round(q(2))); %ymax
                    % Nouvelle image
                    im(sp(2):sp(4), sp(1): sp(3)) = valeur;
                    imagesc(im);
                end
            end
            %
        case {21,22} % Tracer un cercle vide ou plein
            while button ~= 3
                disp ('*** Clic gauche sur le centre du cercle à creer (si fin creation clic droit) ***');
                imagesc(im); % on fait apparaître l'image im
                [p(1),q(1),button] = ginputc(1,'Color','m');
                if button ~= 3
                    disp ('*** Clic gauche sur la frontière de l''obstacle à creer ***');
                    [p(2),q(2),button] = ginputc(1,'Color','m');
                    % Calcul du carré du rayon du cercle
                    rayon2 =(p(2)-p(1))^2 + (q(2)-q(1))^2;
                    % Trace du cercle
                    for i=3:nlig-2
                        for j=3:ncol-2
                            % Calcul du carré de (i,j) à (q(1),p(1))
                            d2 = (double(i)-q(1))^2 + (double(j)-p(1))^2;
                            %
                            if d2 <= rayon2
                                im(i,j) = valeur;
                            end
                        end
                    end
                    % Nouvelle image
                    imagesc(im);
                end
            end
            %
        case {31,32} % Tracer une ellipse vide ou pleine
            while button ~= 3
                disp ('*** Clic gauche sur le premier foyer de l''obstacle à creer (si fin creation clic droit) ***');
                [p(1),q(1),button] = ginputc(1,'Color','m');
                if button ~= 3
                    disp ('*** Clic gauche sur le second foyer de l''obstacle à creer ***');
                    [p(2),q(2)] = ginputc(1,'Color','m');
                    disp ('*** Clic gauche sur la frontière de l''obstacle à creer ***');
                    [p(3),q(3)] = ginputc(1,'Color','m');
                    dfoyers = sqrt((q(3)-q(1))^2 + (p(3)-p(1))^2) + sqrt((q(3)-q(2))^2 + (p(3)-p(2))^2);
                    %
                    % Trace de l'ellipse pleine
                    for i=3:nlig-2
                        for j=3:ncol-2
                            % Calcul de la somme des distances de (i,j) aux
                            % deux foyers de l'ellipse (p(1),q(1))et (p(2),q(2))
                            dsomme= sqrt((double(i)-q(1))^2 + (double(j)-p(1))^2) + sqrt((double(i)-q(2))^2 + (double(j)-p(2))^2);
                            %
                            if dsomme <= dfoyers
                                im(i,j) = valeur;
                            end
                        end
                    end
                    % Nouvelle image
                    imagesc(im);
                end
            end
    end
    close imscene
end