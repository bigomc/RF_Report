clear all
clc

%% Variables initialization
load('Points.mat')

samples=10;
WSx=[];
WSy=[];
WSz=[];
Q1=linspace(-90,90,samples);    %[-90, 90]
Q2=linspace(0,135,samples);     %[0, 135]
Q3=linspace(-135,30,samples);   %[-135, 30]
Q4=linspace(0,180,samples);     %[0, 180]
%Q5=linspace(-90,90,samples);   %[-90, 90]
Q5=0;

%% For-loop iteration for every variable
for q1=Q1
    for q2=Q2
        for q3=Q3
            for q4=Q4
                for q5=Q5
                    theta=[q1 q2 q3 q4 q5];
                    
                    [P R O]=LynxFK(theta);
                    
                    WSx=cat(1,WSx,P(1));
                    WSy=cat(1,WSy,P(2));
                    WSz=cat(1,WSz,P(3));
                end
            end
        end
    end
end

%% Plot the workspace, in 4 different views
fig = figure (1)
%3D view
subplot(2,2,1)
scatter3(WSx, WSy, WSz, '.');
hold on
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]') ;
axis([min(WSx) max(WSx) min(WSy) max(WSy) min(WSz) max(WSz)])
view([1, 1, 1])
title('Workspace')
%2D XY
subplot(2,2,2)
scatter3(WSx, WSy, WSz, '.');
hold on
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]') ;
axis([min(WSx) max(WSx) min(WSy) max(WSy) min(WSz) max(WSz)])
view([0, 0, 1])
title('Workspace XY plane')
%2D  XZ
subplot(2,2,3)
scatter3(WSx, WSy, WSz, '.');
hold on
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]') ;
axis([min(WSx) max(WSx) min(WSy) max(WSy) min(WSz) max(WSz)])
view([0, -1, 0])
title('Workspace XZ plane')
%2D  YZ
subplot(2,2,4)
scatter3(WSx, WSy, WSz, '.');
hold on
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]') ;
axis([min(WSx) max(WSx) min(WSy) max(WSy) min(WSz) max(WSz)])
view([1, 0, 0])
title('Workspace YZ plane')

print(fig,'Workspace_Points','-dpng')
print(fig,'Workspace_Points','-depsc')