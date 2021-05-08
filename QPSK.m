clc;
clear all;
close all;
data=[1 0 0 1 1 0 0 1];
subplot(3,2,1);
stem(data);
title('data before transmitting');
data=2*data-1;
bitrate=10.^3;
fc=bitrate;
tb=1/bitrate;
t=tb/99:tb/99:tb;
split=reshape(data,[2,length(data)/2])
y_in=[];
y_quad=[];
for k=1:length(data)/2
    data_in=split(1,k);
    data_quad=split(2,k);
    t_in=data_in*cos(2*pi*fc*t);
    t_quad=data_quad*sin(2*pi*fc*t);
    y_in=[y_in t_in];
    y_quad=[y_quad t_quad];
end
y = y_in+y_quad;
tx_sig = y;
tt=tb/99:tb/99:(tb*length(data))/2;
subplot(3,2,2);
plot(tt,y_in);
title('inphase component of QPSK modulated signal');
subplot(3,2,3);
plot(tt,y_quad);
title('Quadrature component of QPSK modulated signal');
subplot(3,2,4);
plot(tt,y);
title('QPSK modulated signal');
rx_sig=tx_sig;
DMS=[];
for k=1:length(data)/2
    z_in=rx_sig((k-1)*length(t)+1:k*length(t)).*cos(2*pi*fc*t);
    z_in_intg=trapz(t,z_in)
    if(z_in_intg>0)
        z_in_data=1;
    else
        z_in_data=0;
    end
    z_quad=rx_sig((k-1)*length(t)+1:k*length(t)).*sin(2*pi*fc*t);
    z_quad_intg=trapz(t,z_quad);
    if(z_quad_intg>0)
        z_quad_data=1;
    else
        z_quad_data=0;
    end
    DMS=[DMS z_in_data z_quad_data];
end
subplot(3,2,5);
stem(DMS);
title('Demodulated output');
axis([0,length(DMS)+1,0,1.5]);