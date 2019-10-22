function [flot_max] = get_flot_max(phi,NSUC)
%renvoie le flot max calculé avec le vecteur des flots

phi_max = 0;
for k=1:NSUC(1)
    phi_max = phi_max + phi(k);
end

flot_max = phi_max;
end

