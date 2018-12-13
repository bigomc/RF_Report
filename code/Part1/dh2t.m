function [ T ] = dh2t( row )
%DH2T Summary of this function goes here
%   Detailed explanation goes here

a=row(1);
alpha=row(2);
d=row(3);
theta=row(4);

T=eye(4);
T(1,1)=cos(theta);
T(1,2)=-cos(alpha)*sin(theta);
T(1,3)=sin(alpha)*sin(theta);
T(1,4)=a*cos(theta);

T(2,1)=sin(theta);
T(2,2)=cos(alpha)*cos(theta);
T(2,3)=-sin(alpha)*cos(theta);
T(2,4)=a*sin(theta);

T(3,2)=sin(alpha);
T(3,3)=cos(alpha);
T(3,4)=d;

end

