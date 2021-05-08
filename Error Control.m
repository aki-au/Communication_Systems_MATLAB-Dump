clc;
clear all;
close all;
n = 7;
k = 4;
a=zeros(k,n-k);
b=zeros(k,n-k);
i=eye(k);
for x=1:12
    a(x)=xor(i(x),i(x+4));
end;
for y=1:12
    if y+8<17
        b(y)=xor(a(y),i(y+8));
    else
        b(y)=xor(a(y),i(y-8));
    end;
end;
p=b;
G = [eye(k) p];
H = [p' eye(n-k)];
msg = [1 0 1 1];
code =  mod(msg*G,2);
e = input('where do you want to introduce error?');
code(e) = ~code(e);%introducing error
recd = code;
syndrome = mod(recd*H',2);
find = 0;
for i = 1:n
    if~find
        errvect = zeros(1,n);
        errvect(i) = 1;
        search = mod (errvect*H',2);
        if search == syndrome
            find = 1;
            index = i;
        end
    end
end
disp (num2str(index));%position of error
corrected = recd;
corrected(index)= mod(recd(index)+1,2)
decoded = corrected;
decoded = decoded (1:4);