function [ T ] = dh2td( row )
%DH2TD Summary of this function goes here
%   Detailed explanation goes here

row(2)=deg2rad(row(2));
row(4)=deg2rad(row(4));

T=dh2t(row);

end

