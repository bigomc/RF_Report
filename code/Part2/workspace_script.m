clear all;
clc;

R = 290;
r = 130;
RA = 170;
L = 130;
Ai = []; Pi = []; Xw = []; Yw = [];

sample = 50;
Xc = linspace(-150, 150, sample);
Yc = linspace(-150, 150, sample);
a = 30

%%
for xc = Xc
    for yc = Yc
        T1 = []; T2 = [];  %for each data set(Xc,Yc,a) reset T1,T2 as none for subsequent judgement
        for i=1:3
            A = [R*cosd(90+(i-1)*120),R*sind(90+(i-1)*120),0]';
            P = [r*cosd(90+(i-1)*120), r*sind(90+(i-1)*120),0]';
            Rot_a = [cosd(a) -sind(a) 0; sind(a) cosd(a) 0;0 0 1];
            CP = Rot_a * P;
            BC = [xc yc 0]';
            BP = BC + CP;
            BA = A;
            AP = BP - BA;
            
            e1 = -2*AP(2)*RA;
            e2 = -2*AP(1)*RA;
            e3 = AP(1)^2 + AP(2)^2 + RA^2 - L^2;
            
            t1 = (-e1+(e1^2 + e2^2 - e3^2)^(1/2))/(e3-e2);
            t2 = (-e1-(e1^2 + e2^2 - e3^2)^(1/2))/(e3-e2);
            T1 = cat(2,T1,t1);
            T2 = cat(2,T2,t2);
        end
        
        if isreal(T1) & isreal(T2)>0  % when T1 & T2 are real value, record the coordinate of C(xc,yc)
            Xw = cat(2,Xw,xc);
            Yw = cat(2,Yw,yc);
        else
            disp('no solutions');
        end
    end
end
%% big triangle 
for n=1:3
    A = [R*cosd(90+(n-1)*120),R*sind(90+(n-1)*120),0]';
    Ai = cat(2,Ai,A);
end

%% plot big triangle and point C
Ai = [Ai,Ai(:,1)];
plot(Ai(1,:),Ai(2,:),'r')
hold on
scatter(Xw,Yw,20,'filled','c')
text(-280,220,'workspace of a=30','Color','c','FontSize',12)