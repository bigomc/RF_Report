clear all
clc

%% Declare variables
load('Points.mat')
[m,n]=size(Pn);
error=[];
mag=zeros(m,2);
str='Solution ';

for i=1:2   %Iteration to plot both configurations
    e=[];
    %% Compute inverse kinematics for every point and orientation
    for j=1:m
        [Q]=LynxIK(Pn(j,:)', Rot(:,:,j));
        
        fig=figure(2);
        [P R O]=LynxFK(Q(i,:));
        e=cat(1, e, [Pn(j,:) - P']);
        mag(j,i)=norm([Pn(j,:) - P']);
        
        subplot(1,2,i)
        hold off
        plot3(O(1:5,1), O(1:5,2), O(1:5,3),'ko-','Linewidth',2)
        hold on
        plot3(O(5:6,1), O(5:6,2), O(5:6,3),'r-','Linewidth',2)
        scatter3(P(1), P(2), P(3) , 'x')
        xlabel('x (m)') ; ylabel('y (m)') ; zlabel('z (m)');
        plot3([0 20],[0 0],[0 0], 'b--')
        plot3([0 0],[0 20],[0 0], 'b--')
        plot3([0 0],[0 0],[0 50], 'b--')
        hold off
        axis([-20 21 -20 21 -5 30])
        view([1 1 1])
        title(sprintf('%s%d',str,i))
        grid on
        pause(1)
    end
    error=cat(3, error, e);
end
error
mag
print(fig,'Inverse_Test','-dpng')
print(fig,'Inverse_Test','-depsc')