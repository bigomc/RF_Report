clear all
clc

vias=21;                %vias between points
samples=10;             %samples between vias  
solution=2;             %1st or 2nd solution of IK
Rk=0.05;                %Repulsive constant
obstacle=[14.2 0 0];    %coordinates of obstacle
Pn=[
    7, 10, 0;
    7, -10, 0;
    10.5, 10, 0;
    10.5, -10, 0;
    14, 10, 0;
    14, -10, 0;
    ];                  %Points
Rot=[
    1 0 0;
    0 -1 0;
    0 0 -1;
    ];                  %Orientation
T=[0 5 10 15 20 25];    %Time for each point
[m,n]=size(Pn);
u=zeros(m-1,n);

p_a=[];
q=[];
v=[];
ac=[];
t=[];
viapoints=[];
for i=1:m-1
    %Straigth line sampling from point to point
    t_a=linspace(T(i), T(i+1), vias);
    u(i,:)=(Pn(i+1,:)-Pn(i,:))/(T(i+1)-T(i));   %u=(p2-p1)/(t2-t1)
    p0=Pn(i,:)-u(i,:).*T(i)';                   %p0=p1-u*t1;
    p_a=u(i,:).*t_a' + p0;                      %p=u*t+p0;
    
    %realocate via points if very close to obstacle
    p_b=p_a;
    for j=1:length(t_a)
        r=p_a(j,:)-obstacle;    %distance to obstacle
        d=Rk*r/(norm(r)^3);     %displacement (Rk is constant) similar to
        p_b(j,:)=p_a(j,:)+d;    %gravity F=K*q1*q2/r^2 but 3D
    end
    viapoints=cat(1, viapoints, p_b);
    
    %compute inverse kinematics for every via point
    Q1=[];
    Q2=[];
    for j=1:vias
        aux=LynxIK(p_b(j, :)', Rot);    
        Q1=cat(1, Q1, aux(1,:));
        Q2=cat(1, Q2, aux(2,:));
    end
    Q=cat(3,Q1,Q2);
    clear Q1 Q2
    V=0*Q(1:2,:,1);
    
    %Compute polynomial trayectory (4-3-4) using via points
    %and returning #points between each via
    [q_t, v_t, ac_t, t_t] = TrayVias(Q(:,:,solution), V(:,:), t_a, (vias-1)*samples);
    q=cat(1, q, q_t);
    v=cat(1, v, v_t);
    ac=cat(1, ac, ac_t);
    t=cat(1, t, t_t);
end

%Plot trayectory of joint angles
fig1=figure(1);
subplot(3,1,1)
plot(t,q(:,:))
legend('\theta_1', '\theta_2', '\theta_3', '\theta_4', '\theta_5')
title('Joint trajectories')
xlabel('time [s]'); ylabel('\theta_i [deg]')
subplot(3,1,2)
plot(t,v(:,:))
legend('\omega_1', '\omega_2', '\omega_3', '\omega_4', '\omega_5')
title('Velocity trajectories')
xlabel('time [s]'); ylabel('\omega_i [deg/s]')
subplot(3,1,3)
plot(t,ac(:,:))
legend('\alpha_1', '\alpha_2', '\alpha_3', '\alpha_4', '\alpha_5')
title('Aceletarion trajectories')
xlabel('time [s]'); ylabel('\alpha_i [deg/s^2]')

%plot correspoindig configuration using FK for every point
for i=1:length(t)
    fig2=figure(2);
    [P R O]=LynxFK(q(i,:));
    LynxPlot
    pause(0.1);
end

print(fig1,'images/Trajectory_Joint','-dpng')
print(fig2,'images/Trajectory_Cartesian','-dpng')
