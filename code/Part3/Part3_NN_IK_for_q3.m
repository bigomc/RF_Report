clear all
clc

%% input data
load('NN_input.mat');
load('NN_output_q3.mat');

%% data pretreatment
p = [T_1; T_2; T_3; R_1; R_2; R_3; R_4; R_5; R_6; R_7; R_8; R_9];  % input
t = [q_3];  % output
[pn, inputStr] = mapminmax(p);  % normalize training data 
[tn, outputStr] = mapminmax(t);

%% bulit BP neural network
net = newff(pn, tn, [15 15 15 15 15 15 15 15 15 15], {'purelin', 'logsig', 'purelin'}); % structure of hidden layers

net.trainParam.show = 10;  % show outcomes every 10 iterations
net.trainParam.epochs = 1000;  % maximum training iterations
net.trainParam.lr = 0.05;  % learning rate
net.trainParam.goal = 0.000001;  % expected error
net.divideFcn = '';  % cancel default

%% train neural network
net = train(net, pn, tn);  % training network

%% save network
save('NN_already_trained_for_q3','net');

%% data aftertreatment
prediction = sim(net, pn); % simulating by sim
prediction_1 = mapminmax('reverse', prediction, outputStr)  % inverse normalization

%% plot predicted q3
a1 = prediction_1(1,1001:1020);  %predicted q3
Q_3 = q_3(1001:1020);

N = [1:1:20];
figure(1);
subplot(2, 1, 1);
plot(N, a1, 'ro', N, Q_3, 'b+');  % Comparison between predicted value and true value
legend('predicted q3', 'true q3');
ylabel('angle');
title('comparison between prediction and true value of q3');
grid on;
