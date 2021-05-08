clc;
clear all;
d = [1 0 1 0]
T = 100;
Tb = 0:0.01:2*T
t = 0:0.01:length(d)*2*T
f = 1/T;
c = cos(2*pi*f*t);
p = []
for i = 1:length(d)
    for j = 1:length(Tb)
        p = [p d(i)];
    end
end
subplot (611)
plot (p)
ylim ([-1.5 1.5])
subplot(612)
plot(c)
c = [c 0 0 0]
ask = p.*c;
subplot (613)
plot(ask);
demod = [];
SNR = 10;
askn = awgn (ask,SNR);
r = askn.*c;
subplot (614)
plot(askn);
subplot (615)
plot(r)
for k=1:length(d)
    s = sum (r(((k-1)*200*T)+1 : 200*k*T))
    if s>100
        demod = [demod 1]
    else
        demod = [demod 0]
    end
end
de = [];
for l=1:length(d)
    for j = 1:length(Tb)
        de = [de demod(l)];
    end
end
subplot (616)
plot(de);
ylim ([-1.5 1.5])