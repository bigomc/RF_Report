function [ q, v, ac, t ] = TrayVias( Q, V, T, samples )
%TRAYVIAS Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(Q);
n=floor(samples/(m-1));

q=[];
v=[];
ac=[];
t=[];
for i=1:m-1
    q_a=[];
    v_a=[];
    ac_a=[];
    t_a=[];
    if((i==1)||(i==m-1))
        if(i==1)
            aux=1;
        else
            aux=2;
            if(n*i ~= samples);
                n=samples-n*(i-1);
            end
        end
        [q_a, v_a, ac_a, t_a]=Tray4(Q(i:i+1,:),V(aux,:),T(i:i+1),aux,0,n);
    else
        [q_a, v_a, ac_a, t_a]=Tray3(Q(i:i+1,:),v(n*(i-1),:),T(i:i+1),n);
    end
    q=cat(1, q, q_a);
    v=cat(1, v, v_a);
    ac=cat(1, ac, ac_a);
    t=cat(1, t, t_a);
end
end

