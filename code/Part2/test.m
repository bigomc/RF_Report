clear all;
clc;
clf;

rbase = 290;
rplat = 130;
ra = 170;
L = 130;
N=3;
samples=100;

%%%% User input
Xc = 30;
Yc = -40;
a = 10;

%% Create triangles
PB = zeros(N+1, 2);
PP = zeros(N+1, 2);
PP_pb = zeros(N, 2);
M_pb = zeros(2,2);
M = zeros(N, 2);
M = cat(3, M, zeros(N, 2));
cr = [];
cb = [];
Rpb_b = [];
Tpb_b = [];
LEG_r = [];
LEG_l = [];
theta = [];
for i=1:N
    PB(i,1)=rbase*cos(2*pi/N*i-pi/6);
    PB(i,2)=rbase*sin(2*pi/N*i-pi/6);
    PP(i,1)=rplat*cos(2*pi/N*i-pi/6 + deg2rad(a)) + Xc;
    PP(i,2)=rplat*sin(2*pi/N*i-pi/6 + deg2rad(a)) + Yc;
    
    alpha=2*pi/N*i-4*pi/3;
    Rpb_b=cat(3, Rpb_b, [cos(alpha) -sin(alpha);sin(alpha) cos(alpha)]);
    Tpb_b=cat(3, Tpb_b, [Rpb_b(:,:,i) PB(i,:)'; 0 0 1]);
    aux =(inv(Tpb_b(:,:,i))*[PP(i,:)';1])';
    PP_pb(i,:) = aux(1:2);
    
    e1 = -2*PP_pb(i,2)*ra;
    e2 = -2*PP_pb(i,1)*ra;
    e3 = PP_pb(i,1)^2 + PP_pb(i,2)^2 + ra^2 - L^2;

    t1 = (-e1+sqrt(e1^2 + e2^2 - e3^2))/(e3-e2);
    t2 = (-e1-sqrt(e1^2 + e2^2 - e3^2))/(e3-e2);
    
    st1 = (2*t1)/(1+t1^2);
    ct1 = (1-t1^2)/(1+t1^2);
    
    st2 = (2*t2)/(1+t2^2);
    ct2 = (1-t2^2)/(1+t2^2);
    
    theta1 = atan2(st1,ct1);
    theta2 = atan2(st2,ct2);
    
    theta = cat(1, theta, [theta1 theta2]);
    
    M_pb(i, 1) = ra*cos(theta1);
    M_pb(i, 2) = ra*sin(theta1);
    aux=Tpb_b(:,:,i)*[M_pb(i, :)';1];
    aux(3)=[];
    M(i,:,1)=aux';
    LEG_r=cat(3, LEG_r, [PB(i,:);M(i,:,1);PP(i,:)]);
    
    M_pb(i, 1) = ra*cos(theta2);
    M_pb(i, 2) = ra*sin(theta2);
    aux=Tpb_b(:,:,i)*[M_pb(i, :)';1];
    aux(3)=[];
    M(i,:,2)=aux';
    LEG_l=cat(3, LEG_l, [PB(i,:);M(i,:,2);PP(i,:)]);
end
PB(N+1,1)=PB(1,1);
PB(N+1,2)=PB(1,2);
PP(N+1,1)=PP(1,1);
PP(N+1,2)=PP(1,2);

%% Plot 1
fig1 = figure(1);
hold on
plot(PB(:, 1), PB(:, 2), 'ko-', 'Linewidth',2)
plot(PP(:, 1), PP(:, 2), 'ro-', 'Linewidth',2)
scatter([0], [0], 'kx')
scatter([Xc], [Yc], 'rx')
for i=1:N
    plot(LEG_r(:,1,i), LEG_r(:,2,i), 'bo-','Linewidth',2)
    plot(LEG_l(:,1,i), LEG_l(:,2,i), 'bo-','Linewidth',2)
end

aux=linspace(0, 2*pi, samples);
for i=1:N
    cr=cat(3,cr,[L*cos(aux) + PP(i, 1);L*sin(aux) + PP(i, 2)]);
    cb=cat(3,cb,[ra*cos(aux) + PB(i, 1);ra*sin(aux) + PB(i, 2)]);
    plot(cr(1,:,i), cr(2,:,i), 'r--')
    plot(cb(1,:,i), cb(2,:,i), 'k--')
end
hold off

