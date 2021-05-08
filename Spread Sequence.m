clc;
clear all; close all;
%% PN Seq Generation
x1=0;
x2=1;
x3=0;
pn=[];
pn(1)=x3;
for i =[2:7]
    j=i-1;
    x3=x2;
    x2=x1;
    x1=mod(pn(j)+x1,2)
pn(i)=x3
end

o = 0;
z = 0;
flag1=0;

% for i= 1:7
%     if pn(i) == 1
%         o = o+1;
%     else
%         z = z+1;
%     end
% end
% flag2 =0;
% check = [];
% if o == z+1
%     flag1=1
%     disp ('balanced')
%     for i = 1:5
%         check = [pn(i) pn(i+1) pn(i+2)];
%         if check == [1 1 1]
%             flag2=1
%         end
%     end
% else
%     disp('Not Balanced')
% end

%% Verifying PN seq Property
nz = find(pn);
z = find (pn==0);

if length(nz)==(length(z)+1)
    for i=1:2
        d = 0;
        e = 0;
        d = nz(i+1)- nz(i);
        e = nz(i+2)- nz(i+1);
        if d == 1 && e==1
            flag1 = 1;
        end
    end
else
    disp('balance not satisfied')
end

flag2 = 0;
i = 1;

if flag1 ==1
    d = 0;
    e=0;
    d = z(i+1)-z(i);
    e = z(i+2)- z(i+1);
    if d == 1 || e==1
        flag2 =1;
    end
end

%% SS
if (flag1==1&&flag2==1)
    d=[1 0 1]
    tc=length(pn)
    tb=7*tc;
    b=repmat(pn,tc,length(d))
    b1=b(:)'
    polarb=(2*b1)-1

    n=length(b1)
    a=(n-1)/tc
    t=0:1/tc:a 
    subplot(311)
    stairs(polarb)
    ylim([-2 2])
    xlim([0 21])
    title('PN Sequence')

    d1=repmat(d,tb,1)
    d11=d1(:)'
    polard=(2*d11)-1
    subplot(312)
    stairs(polard)
    ylim([-2 2])
    title ('Message Data')

    m=polard.*polarb
    subplot(313)
    stairs(m)
    ylim([-2 2])
    xlim([0 21])
    title('Spreaded Sequence')

    fc=1000
    c=sin(2*pi*fc*t)
    figure
    subplot(311)
    plot(t,c)
    ylim([-1.5 1.5])
    xlim([0 21])
    title('carrier')

    bpsk=m.*c;
    subplot(312)
    plot(t,bpsk)
    ylim([-1.5 1.5])
   % xlim([0 2 1])
   title('modulated wave')
    
 %%demodulation
    r=awgn(bpsk,12,'measured')
    subplot(313)
    plot(t,r)
    title('Modified wave due to Noise')
    
    t1=0:1/tc:(1-(1/tc)) 
    c1=sin(2*pi*fc*t1)
    figure
    subplot(211)
    plot(c1)
    arr=[]
    
    for j=1:tc:length(r)
        h=r(j:j+tc-1).*c1
    if sum(h)>0
        arr=[arr 1]
    else
         arr=[arr 0]
    end
    end
    
    b=repmat(arr,tc,1)
    b=b(:)'
    b1=2*b-1;
    
    figure
    subplot(211)
    stairs(t,b1)
    title('Demodulated signal')
    ylim([-1.5 1.5])
    xlim([0 21])
    
    demodata=b1.*polarb
    demodata=(demodata+1)/2
    subplot(212)
    stairs(t,demodata)
    ylim([-1.5 1.5])
    xlim([0 21])
    title ('demod msg signal')
    
    drr=[]
    for j=[1:7*tc:length(demodata)]
    disp(j)
    if demodata(j:j+7*tc-r)>0
        drr=[drr 1]
    else
        drr=[drr 0]
    end
    end
    
    disp(drr)
        
    
else
    disp('not satisfied')
end


