function [ P , R , O ] = LynxFK( Q )
%LYNXFK Forward kinematics of Lynxmotion robot
%   This function computes the forwar kinematics of the Lynxmotion robot
%   given a row vector Q containing the values of the five joints of the
%   robot in degrees.
%   The return value is the Position (P) and Orientation (R) of the end 
%   effector, also a vector O(6,3) is returned. Every row (i) represent the
%   coordinates of point Oi=[Oxi Oyi Ozi] with respecto to main frame. 

a=[0 9.5 11 0 0];       %Parameter a of DH table for Lynxmotion robot
alpha=[90 0 0 90 0];    %Parameter alpha of DH table for Lynxmotion robot
d=[6.5 0 0 0 3.2];      %Parameter d of DH table for Lynxmotion robot
theta=[Q(1) Q(2) Q(3) Q(4) Q(5)];   %Joint values Lynxmotion robot

N=5;                    %Number of joints
H=eye(4);               %Initialize homogeneous resultant matrix
O=zeros(N+1, 3);        
for n=1:N
    table(n,:)=[
        a(n) alpha(n) d(n) theta(n)
        ];
    T(:,:,n)=dh2td(table(n,:)); %Compute the T matrix of row n
    H=H*T(:,:,n);               %Multiply the T matrix to create H_0n
    
    O(n+1,1)=H(1,4);            %Store Oxi
    O(n+1,2)=H(2,4);            %Store Oyi
    O(n+1,3)=H(3,4);            %Store Ozi
end

P=H(1:3, 4);                    %Store Position of end effector
R=H(1:3, 1:3);                  %Store Orientation of end effector

end

