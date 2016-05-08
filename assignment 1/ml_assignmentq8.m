n = [];
vec = [];
for i = 1:100
    k = normrnd(5,2,[1 10]);
    n = [n;k];
    vec = [vec k];
end
m = mean(n');
% 100 mean values 
v = var(n');
% 100 variance values 
%bias and variance of mean
main_bias = mean(m)-5;

main_variance = var(m);
%bias and variance of variance estimator
all_variance = var(vec);
bias_of_variance = all_variance - 2;
% variance of variance estimator 
var_of_var = var(v);

display('Bias of mean estimator  ');
disp(main_bias);
display('Variance of mean estimator  ');
disp(main_variance);
display('Bias of variance estimator ');
disp(bias_of_variance);
display('Variance of variance estimator ');
disp(var_of_var);



