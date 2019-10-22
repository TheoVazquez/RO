function [ANT] = get_ant(NSUC, SUC, CAPACITE)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = size(NSUC,2);
ANT= zeros(n,n)-1;
nbsucv = 0;

for i = 1:n
    for j  = 1:NSUC(i)
        ANT(i,SUC(nbsucv+j)) = CAPACITE(nbsucv+j);
    end
    nbsucv=nbsucv + NSUC(i);
end
end

