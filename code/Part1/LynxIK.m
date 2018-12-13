function [ Q ] = LynxIK( P, R )
%LYNXIK Inverse kinematics of Lynxmotion robot
%   This fuction computes the inverse kinematics of the Lynxmotion robot
%   given a column vector (P) with the coordinates x,y,z of the desired
%   position and 3 by 3 matrix (R) that represents the desired orientation
%   at point P.
%   The return value is a row vector Q containing the values of the five joints of the
%   robot in degrees.

a=[0 9.5 11 0 0];       %Parameter a of DH table for Lynxmotion robot
alpha=[90 0 0 90 0];    %Parameter alpha of DH table for Lynxmotion robot
d=[6.5 0 0 0 3.2];      %Parameter d of DH table for Lynxmotion robot

Px=P(1);
Py=P(2);
Pz=P(3);

%% Joint 1
q1 = atan2(Py, Px);
T10 = [cos(q1) sin(q1) 0 0;0 0 1 -d(1);sin(q1) cos(q1) 0 0;0 0 0 1];

%% Joint 2 and 3
Oc_0 =[Px;Py;Pz] - d(5)*(R * [0 0 1]'); %Oc is center of frame 3 and 4
Oc_1 = T10*[Oc_0;1];

C3 = (Oc_1(1)^2 + Oc_1(2)^2 - a(2)^2 - a(3)^2)/(2*a(2)*a(3));
if(C3 > 1)
    C3 = 1;
end
if(C3 < -1)
    C3 = -1;
end
S31 = sqrt(1-C3^2);
S32 = -sqrt(1-C3^2);
q31=atan2(S31,C3);
q32=atan2(S32,C3);

sa= a(3)*sin(q31)/sqrt(Oc_1(1)^2 + Oc_1(2)^2);
ca= sqrt(1-sa^2);
q21=atan2(Oc_1(2),Oc_1(1)) - atan2(sa,ca);

sa= a(3)*sin(q32)/sqrt(Oc_1(1)^2 + Oc_1(2)^2);
ca= sqrt(1-sa^2);
q22=atan2(Oc_1(2),Oc_1(1)) - atan2(sa,ca);

T31_1=[
    cos(q21+q31) sin(q21+q31) 0 -Oc_1(1)*cos(q21+q31)-Oc_1(2)*sin(q21+q31);
    -sin(q21+q31) cos(q21+q31) 0 Oc_1(1)*sin(q21+q31)-Oc_1(2)*cos(q21+q31);
    0 0 1 0;
    0 0 0 1
    ];

T31_2=[
    cos(q22+q32) sin(q22+q32) 0 -Oc_1(1)*cos(q22+q32)-Oc_1(2)*sin(q22+q32);
    -sin(q22+q32) cos(q22+q32) 0 Oc_1(1)*sin(q22+q32)-Oc_1(2)*cos(q22+q32);
    0 0 1 0;
    0 0 0 1
    ];

%% Joint 4
T30_1=T31_1*T10;
T30_2=T31_2*T10;

P_31=T30_1*[Px;Py;Pz;1];
P_32=T30_2*[Px;Py;Pz;1];

q41=atan2(P_31(1)/d(5), -P_31(2)/d(5));
q42=atan2(P_32(1)/d(5), -P_32(2)/d(5));

T43=[
    cos(q41) sin(q41) 0 0;
    0 0 1 0;
    sin(q41) -cos(q41) 0 0;
    0 0 0 1
    ];

%% Joint 5
T40=T43*T30_1;
T05=[R P;0 0 0 1];
T45=T40*T05;

q5=atan2(T45(1,2), T45(1,1));

Q=[
    q1 q21 q31 q41 q5;
    q1 q22 q32 q42 q5;
    ];
Q=rad2deg(Q);

end

