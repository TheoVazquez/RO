clear all;

% Valeurs initiales
C1 = 5;
C2 = 10;
C3 = 10;
C4 = 5;
v = 20;
liste_S = 5:50; % 15 et 10
liste_s = 1:50;
liste_combis = []; % contiendra les couples [S, s, B]
[x,y,liste_gain] = deal([]);

for S = liste_S
    
for s = liste_s
    
if S > s
    
x = [x , S];
y = [y , s];
    
% Définition de la loi alpha comme étant une loi de poisson avec lambda=10
lambda = 10;
flaws = 0:(10*lambda);
alpha = poisspdf(flaws,lambda);
somme = sum(alpha);


% Matrice de transition
P = zeros(S+1,S+1);
% Construire la ligne 1 et S+1 de P
for i = 1:S+1
    P(1,i) = alpha(S+2-i);
    P(S+1,i) = P(1,i);
end
% Les s-1 premières lignes de P
for i = 1:s
    P(i,:) = P(1,:);
end
% Les S-s+1 dernières lignes de P
for i = 1:(S-s)
    P(S+1-i,1) = P(S+2-i,1)+P(S+2-i,2); % La première case de la ligne est l'addition de la case du dessous et de la case du dessous à droite
    for j = 2:S+1
        if j ~= S+1
            P(S+1-i,j) = P(S+2-i,j+1); % Une case est égale à la case en dessous à droite
        else
            P(S+1-i,j) = 0; % Sauf la dernière colonne où on rajoute 0
        end
    end
end

% Matrice de distribution limite
PI = zeros(1, length(P)+1); 
Mat_lim_a = [(eye(size(P))-P),ones(length(P),1)];
[p,q] = size(Mat_lim_a);
Mat_lim = [Mat_lim_a ; ones(1,length(P)+1)];

% Matrice de calcul
Resultat = [zeros(1,length(P)),1];

% PI*(Mat_lim) = Resultat
PI = Resultat / (Mat_lim);

% Détermination du gain

jk1 = 1:(length(alpha)-S);
jk2 = jk1+S;
jk3 = min(S, 1:length(alpha));
jk4 = 1:s-1;
jk6 = (1+s):(length(alpha));
jk7 = 1:length(jk6);

% Première partie de la formule
gain = PI(jk4)*(-C1*S-C2*jk1*alpha(jk2)'-C3-C4*(S-jk4)+v*jk3*alpha')'; 

% Seconde partie de la formule
for varj = s:S
    gain = gain + PI(j)*(-C1*varj-C2*jk7*alpha(jk6)'+v*min(varj,1:length(alpha))*alpha');
end

liste_gain = [liste_gain,gain];
liste_combis = [liste_combis; [S,s,gain]];

end

end

end

figure
% plot(1:length(liste_combis),liste_combis(:,3)) % vue 2D du gain en
% fonction du numéro de l'itération
plot3(liste_combis(:,1),liste_combis(:,2),liste_combis(:,3));
title('Variation du gain en fonction de S et s');
xlabel('Valeur de S');
ylabel('Valeur de s');
zlabel('Valeur du gain (B)');
