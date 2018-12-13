function [ q, v, ac, t ] = Tray4( Q, V, T, ta, ac, samples )
%TRAY4 Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(Q);
a=poly4C(Q, V, T, ta, ac);
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

