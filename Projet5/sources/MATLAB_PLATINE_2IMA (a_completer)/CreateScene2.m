% CreateScene2
%
close all
% INITIALISATION
lig = input('*** Donner le nombre de lignes de la scene :','s');
lig= str2double(lig);
nlig=int16(lig);
col= input('*** Donner le nombre de colonnes de la scene :','s');
col= str2double(col);
ncol=int16(col);
%
im= ones(nlig,ncol,'int16'); % initialisation de im a 1
%
im(1:2,1:ncol) = 7; % les 2 premieres lignes a 7
im(nlig-1:nlig,1:ncol) = 7; % les 2 dernieres lignes a 7
im(1:nlig,1:2) = 7;  % les 2 premieres colonnes a 7
im(1:nlig,ncol-1:ncol) = 7; % les 2 dernieres colonnes a 7
%
colormap(jet); % initialisation table couleur
%
figure ('Name','imscene'); %creation nouvelle figure
imagesc(im); % on fait apparaître l'image im de la scene vide
%
continuer = true;
while continuer % boucle infinie
    %
    disp('***')
    disp('Pour tracer un rectangle plein, taper 1');
    disp('Pour tracer un cercle plein, taper 2');
    disp('Pour tracer une ellipse pleine, taper 3');
    disp('***')
    %
    reponse = input('Reponse ? ');
    %
    if isempty(reponse)
        figure ('Name','imscene');
        imagesc(im);
        return
    end
    %
    switch reponse
        case 1 % Tracer un rectangle plein
            button = 0;
            clear imscene
            hscene = figure ('Name','imscene'); %creation nouvelle figure
            imagesc(im); % on fait apparaître l'image im
            while button ~= 3 % button == 3 <=> clic droit
                disp ('*** Clic gauche sur un coin de l''obstacle à creer (si fin creation clic droit) ***');
                [p(1),q(1),button] = ginputc(1,'Color','y');
                if button ~= 3
                    disp ('*** Clic gauche sur un autre coin de l''obstacle à creer ***');
                    [p(2),q(2)] = ginputc(1,'Color','y');
                    % Get the x and y corner coordinates as integers
                    sp(1) = min(round(p(1)), round(p(2))); %xmin
                    sp(2) = min(round(q(1)), round(q(2))); %ymin
                    sp(3) = max(round(p(1)), round(p(2)));   %xmax
                    sp(4) = max(round(q(1)), round(q(2)));   %ymax
                    % Nouvelle image
                    im(sp(2):sp(4), sp(1): sp(3)) = 7;
                    imagesc(im);
                end
            end
            close imscene
        case 2 % Tracer un cercle plein
            button = 0;
            clear imscene
            hscene = figure ('Name','imscene'); %creation nouvelle figure
            imagesc(im); % on fait apparaître l'image im
            while button ~= 3
                disp ('*** Clic gauche sur le centre de l''obstacle à creer (si fin creation clic droit) ***');
                %hscene.Visible = 'on';
                %openfig('hscene.fig','visible');
                imagesc(im); % on fait apparaître l'image im
                [p(1),q(1),button] = ginputc(1,'Color','y');
                if button ~= 3
                    disp ('*** Clic gauche sur la frontière de l''obstacle à creer ***');
                    [p(2),q(2),button] = ginputc(1,'Color','y');
                    % Calcul du carré du rayon du cercle
                    rayon2 =(p(2)-p(1))^2 + (q(2)-q(1))^2;
                    % Trace du cercle plein
                    for i=3:nlig-2
                        for j=3:ncol-2
                            % Calcul du carré de (i,j) à (q(1),p(1))
                            d2 = (double(i)-q(1))^2 + (double(j)-p(1))^2;
                            %
                            if d2 <= rayon2
                                im(i,j) = 7;
                            end
                        end
                    end
                    % Nouvelle image
                    imagesc(im);
                end
            end
            close imscene
        case 3 % Tracer une ellipse pleine
            button = 0;
            clear imscene
            hscene = figure ('Name','imscene'); %creation nouvelle figure
            imagesc(im); % on fait apparaître l'image im
            while button ~= 3
                disp ('*** Clic gauche sur le premier foyer de l''obstacle à creer (si fin creation clic droit) ***');
                [p(1),q(1),button] = ginputc(1,'Color','y');
                if button ~= 3
                    disp ('*** Clic gauche sur le second foyer de l''obstacle à creer ***');
                    [p(2),q(2)] = ginputc(1,'Color','y');
                    disp ('*** Clic gauche sur la frontière de l''obstacle à creer ***');
                    [p(3),q(3)] = ginputc(1,'Color','y');
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
                                im(i,j) = 7;
                            end
                        end
                    end
                    % Nouvelle image
                    imagesc(im);
                end
            end
            close imscene
    end
end