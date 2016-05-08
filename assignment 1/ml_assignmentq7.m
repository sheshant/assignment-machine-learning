format long;
x = (-pi:0.1:pi);
x2 = x.^2;
x3 = x.^3;
x4 = x.^4;
x5 = x.^5;
x6 = x.^6;
x7 = x.^7;
x8 = x.^8;
x9 = x.^9;
s = size(x);
y = sin(x);
a = [0.1;0.5;1;2;10];
lambda = [0.001;0.01;0.1;1;10;100;1000];
plot(x,y);

%% main task for looping 

for ai = 1:5
    %% task to generate random variables of mean 0 variance 1
    n = normrnd(0,1,[1 s(1,2)]);
    n = n * a(ai,1);
    t = y + n;
    %% now write in file 
    st = strcat('a = ',num2str(a(ai,1)),'- .libsvm');
    fid = fopen(st, 'w');
    for idx = 1:s(1,2)
        fprintf(fid, '%10.10f 1:%10.10f 2:%10.10f 3:%10.10f 4:%10.10f 5:%10.10f 6:%10.10f 7:%10.10f 8:%10.10f 9:%10.10f \r\n' ,t(1,idx),x(1,idx),x2(1,idx),x3(1,idx),x4(1,idx),x5(1,idx),x6(1,idx),x7(1,idx),x8(1,idx),x9(1,idx));
    end
    fclose(fid);
end
