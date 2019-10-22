function d = point_to_segment(x,y,x2,y2,x3,y3)
%
% d est la distance euclidienne de P(x,y) au segment [P2(x2,y2),P3(x3,y3)]
%
A = zeros(2,2);
dif = [x3-x2 , y3-y2 , 0]; % P3 - P2
A(1,1) = dot([x3 y3 0],dif); % (P3 | P3 - P2]
A(1,2) = dot([x2 y2 0],dif); % (P2 | P3 - P2]
A(2,:) = [1 1];
%
b = [dot([x y 0],dif);1];
sol = A\b; % sol = [lambda;mu]
if sol(1) > 0 && sol(1) < 1
    d = norm(cross(dif,[x-x2,y-y2,0])/norm(dif));
elseif sol(1) <= 0
    d = sqrt((x-x2)^2 + (y-y2)^2);
else
    % sol(1) >= 1
    d = sqrt((x-x3)^2 + (y-y3)^2);
end