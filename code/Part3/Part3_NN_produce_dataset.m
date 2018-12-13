clear all
clc

sample = 10; %% number of angles
joints = 5; %% number of joints

T_1=[]; T_2=[]; T_3=[]; %% initialize the coordinate vetor of EE
R_1=[]; R_2=[]; R_3=[]; R_4=[]; R_5=[]; R_6=[]; R_7=[]; R_8=[]; R_9=[];
q_1=[]; q_2=[]; q_3=[]; q_4=[]; q_5=[];

Q1 = linspace(0, 18, sample);   %% divide angle into sample number points
Q2 = linspace(0, 18, sample);
Q3 = linspace(0, 18, sample);
Q4 = linspace(0,  18, sample);
Q5 = linspace(0,  18, sample);

a     = [0 95 110 0 0];  
alpha = [90 0 0 90 0];
d     = [65 0 0 0 32];

for q1 = Q1
    for q2 = Q2
        for q3 = Q3
            for q4 = Q4
                for q5 = Q5
                    theta = [q1 q2 q3 q4 q5];
                    H=eye(4);
                    Px=zeros(1,joints); %% initialization
                    Py=zeros(1,joints);
                    Pz=zeros(1,joints);
                    
                    for n = 1:joints %% get 5 joint points from 1 set of q
                        table(n,:) = [a(n) alpha(n) d(n) theta(n)];
                        HT(:,:,n) = DH_to_HT( a(n),alpha(n),d(n),theta(n) );
                        H = H*HT(:,:,n);
                        if n==4
                            Px(n+1)=H(1,4)+20*H(1,3); 
                            Py(n+1)=H(2,4)+20*H(2,3);
                            Pz(n+1)=H(3,4)+20*H(3,3);
                        else
                            Px(n+1)=H(1,4); %% coordinates of joint points are in the forth column of HT                            Py(n+1)=H(2,4);
                            Pz(n+1)=H(3,4);
                        end
                    end
                    
                    T_1 = cat(2, T_1, H(1,4)); %% save T & R as vectors, to be the input for neural network
                    T_2 = cat(2, T_2, H(2,4));
                    T_3 = cat(2, T_3, H(3,4));
                    R_1 = cat(2, R_1, H(1,1));
                    R_2 = cat(2, R_2, H(1,2));
                    R_3 = cat(2, R_3, H(1,3));
                    R_4 = cat(2, R_4, H(2,1));
                    R_5 = cat(2, R_5, H(2,2));
                    R_6 = cat(2, R_6, H(2,3));
                    R_7 = cat(2, R_7, H(3,1));
                    R_8 = cat(2, R_8, H(3,2));
                    R_9 = cat(2, R_9, H(3,3));
                    q_1 = cat(2, q_1, q1);
                    q_2 = cat(2, q_2, q2);
                    q_3 = cat(2, q_3, q3);
                    q_4 = cat(2, q_4, q4);
                    q_5 = cat(2, q_5, q5);
                end
            end
        end
    end
end
save('NN_input','T_1','T_2','T_3','R_1','R_2','R_3','R_4','R_5','R_6','R_7','R_8','R_9'); 
save('NN_output','q_1','q_2','q_3','q_4','q_5'); 
save('NN_output_q3','q_3'); 
