view3d=subplot(1,2,1);
if(~exist('trayectory'))
   trayectory=[]; 
end
xlim manual
ylim manual
zlim manual
trayectory=cat(1, trayectory, P');
hold off
plot3(trayectory(:,1), trayectory(:,2), trayectory(:,3))
hold on
plot3(O(1:5,1), O(1:5,2), O(1:5,3),'ko-','Linewidth',2)
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
if(exist('obstacle'))
    scatter3(obstacle(:,1), obstacle(:,2), obstacle(:,3) , 'filled', 'd')
end
plot3(O(5:6,1), O(5:6,2), O(5:6,3),'r-','Linewidth',2)
plot3([0 20],[0 0],[0 0], 'b--')
plot3([0 0],[0 20],[0 0], 'b--')
plot3([0 0],[0 0],[0 50], 'b--')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]');
axis([-20 21 -20 21 -5 30])
view([1 1 1])
title('3D view of Lynxmotion')
grid on

view2d=subplot(1,2,2);
if(~exist('trayectory'))
   trayectory=[]; 
end
xlim manual
ylim manual
zlim manual
trayectory=cat(1, trayectory, P');
hold off
plot3(trayectory(:,1), trayectory(:,2), trayectory(:,3))
hold on
plot3(O(1:5,1), O(1:5,2), O(1:5,3),'ko-','Linewidth',2)
scatter3(Pn(:,1), Pn(:,2), Pn(:,3) , 'filled', 'd')
scatter3(viapoints(:,1), viapoints(:,2), viapoints(:,3) , 'x')
if(exist('obstacle'))
    scatter3(obstacle(:,1), obstacle(:,2), obstacle(:,3) , 'filled', 'd')
    text(obstacle(:,1)+1, obstacle(:,2)+1, obstacle(:,3),'Obstacle') ;
end
plot3(O(5:6,1), O(5:6,2), O(5:6,3),'r-','Linewidth',2)
plot3([0 20],[0 0],[0 0], 'b--')
plot3([0 0],[0 20],[0 0], 'b--')
plot3([0 0],[0 0],[0 50], 'b--')
hold off
xlabel('x [cm]') ; ylabel('y [cm]') ; zlabel('z [cm]');
axis([-20 21 -20 21 -5 30])
view([0 0 1])
title('Upper view of Lynxmotion')
grid on