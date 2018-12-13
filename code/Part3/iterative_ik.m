clear all
clc

%% Definition of parameters and variables
a1=20;
a2=10;
alpha=0.1;
error=[];
Q=[];

%% Desired position computed using FK
q = deg2rad([30 90])';
Pd=[
    a1*cos(q(1))+a2*cos(q(1)+q(2));
    a1*sin(q(1))+a2*sin(q(1)+q(2))
    ];
%% Current position
q = deg2rad([45 60])';
P=[
    a1*cos(q(1))+a2*cos(q(1)+q(2));
    a1*sin(q(1))+a2*sin(q(1)+q(2))
    ];
Q=cat(1,Q,rad2deg(q'));

e=Pd-P;
error=cat(1,error,[e' norm(e)]);
while(norm(e) > 0.01)
    J=[
        -a1*sin(q(1))-a2*sin(q(1)+q(2)) -a2*sin(q(1)+q(2));
        a1*cos(q(1))+a2*cos(q(1)+q(2)) a2*cos(q(1)+q(2))
        ];
    J_inv=J'*inv(J*J');
    
    dq=J_inv*(e);
    q=q+alpha*dq;
    q(1)=min(180, max(-180, q(1)));
    q(2)=min(180, max(-180, q(2)));
    Q=cat(1,Q,rad2deg(q'));
    
    P=[
        a1*cos(q(1))+a2*cos(q(1)+q(2));
        a1*sin(q(1))+a2*sin(q(1)+q(2))
        ];
    e=Pd-P;
    
    error=cat(1,error,[e' norm(e)]);
end

%%Plots
fig1=figure(1);
plot(Q)
xlabel('iterations')
ylabel('q_i [deg]')
legend('q_1', 'q_2')
title('Joint value update')

fig2=figure(2);
plot(error)
xlabel('iterations')
ylabel('error (\Delta x) [cm]')
legend('e_x', 'e_y', '|e|')
title('Error value update')

print(fig1,'Trajectory_Joint_p3_rodrigo','-dpng')
print(fig2,'error_p3_rodrigo','-dpng')