function [ q, v, ac, t ] = Tray3( Q, V, T, samples )
%TRAY3 Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(Q);
a=poly3C(Q, V, T);
t=linspace(T(1), T(2), samples)';

q=[];
v=[];
ac=[];
for j=1:n
    q_a=polyval(a(:,j),t);
    v_a=polyval(polyder(a(:,j)),t);
    ac_a=polyval(polyder(polyder(a(:,j))),t);
    q=cat(2, q, q_a);
    v=cat(2, v, v_a);
    ac=cat(2, ac, ac_a);
end
end

