clc;
clear all;
t=0:0.01:1;
fc = 0.5;
m = [];
m = [1 0 0 0 1 0 0 1 0 1];
mess=[];
c=[];
bpsk=[];
q1=[];
q2=[];
for i=1:10
    if m(i) == 1
        bpsk=[bpsk sin(2*pi*fc*t)];
        mess=[mess ones(1,length(t))];
    else
        bpsk=[bpsk sin(2*pi*2*fc*t)];
        mess=[mess zeros(1,length(t))];
    end
    c=[c cos(2*pi*fc*t)];
    q1=[q1 sin(2*pi*fc*t)];
    q2=[q2 sin(2*pi*2*fc*t)];
end
subplot(2,4,1);
plot(mess);
ylim ([-0.5 1.5])
xlim ([0 1010])
subplot(2,4,2);
plot(c);
ylim ([-1.5 1.5])
xlim ([0 1010]) 
subplot(2,4,3);
plot(bpsk);
ylim ([-1.5 1.5])
xlim ([0 1010]) 
r=awgn(bpsk,10);
de1= r.*q1;
de2= r.*q2;
subplot(2,4,4);
plot(r);
ylim ([-1.5 1.5])
xlim ([0 1010]) 
subplot(2,4,5);
plot(de1);
ylim ([-1.5 1.5])
xlim ([0 1010]) 
subplot(2,4,6);
plot(de2);
ylim ([-1.5 1.5])
xlim ([0 1010]) 
reme=[];
for i= 1:10
    k1 = sum(de1((1+(i-1)*length(t)):(i*length(t))));
    k2 = sum(de2((1+(i-1)*length(t)):(i*length(t))));
    if (k1 - k2) > 0
        reme = [reme ones(1,length(t))];
    else
        reme = [reme zeros(1,length(t))];
    end
end
subplot(2,4,7);
plot(reme);
ylim ([-0.5 1.5]);
xlim ([0 1010]);