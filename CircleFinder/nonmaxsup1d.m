function [xList, maxX] = nonmaxsup1d(list, threshhold)
% Überprüft ob eintrag größer als Treshhold ist
% Setzt auf 1 wenn der Fall
if(~isempty(list))
    list = [list(1);list;list(end)];
    dx = list(2:end)-list(1:end-1);
    zc = max(sign(sign(dx(1:end-1))-sign(dx(2:end))),0);
    tx = (list>threshhold);
    maxX = tx(2:end-1).*zc;
    n = 1:length(maxX);
    xList =  n(maxX==1);
else
    xList = [];
    maxX = [];
end