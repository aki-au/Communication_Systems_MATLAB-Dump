clc;
clear all;
close all;
t=0:0.01:1;
fc=1;
m=[1 0 0 0 1 0 0 1 0 1];
mess=[];
c=[];
bfsk=[];
for i=1:10
    if m(i) == 1
        bfsk=[bfsk sin(2*pi*fc*t+pi)];
        mess=[mess ones(1,length(t))];
    else
        bfsk=[bfsk sin(2*pi*fc*t)];
        mess=[mess zeros(1,length(t))];
    end
    c=[c sin(2*pi*fc*t)];
end
subplot(2,3,1);
plot(mess);
subplot(2,3,2);
plot(c);
subplot(2,3,3);
plot(bfsk);
r=awgn(bfsk,10);
de=r.*c;
subplot(2,3,4)
plot(r);
subplot(2,3,5)
plot(de);
reme=[];
for i=1:10
    k=sum(de((1+(i-1)*length(t)):(i*length(t))));
    if k<0
        reme=[reme ones(1,length(t))];
    else
        reme=[reme zeros(1,length(t))];
    end
end
subplot(2,3,6);
plot(reme);