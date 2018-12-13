function [ a ] = poly4C( Q, V, t, ta, ac )
%GETCOEF Summary of this function goes here
%   Detailed explanation goes here

[m,n] = size(Q);
a=[];

M=[
    t(1)^4      t(1)^3      t(1)^2  t(1)    1;  %q0
    t(2)^4      t(2)^3      t(2)^2  t(2)    1;  %qf
    4*t(ta)^3    3*t(ta)^2    2*t(ta)  1       0;  %v0
    12*t(1)^2   6*t(1)      2       0       0   %a0
    12*t(2)^2   6*t(2)      2       0       0   %af
];
for j=1:n
    u=[Q(1,j) Q(2,j) V(1,j) 0 0];
    a=cat(2, a, (inv(M)*u'));
end
end

