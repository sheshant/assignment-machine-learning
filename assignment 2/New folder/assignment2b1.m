[A_label_vector, A_instance_matrix] = libsvmread('breast-cancer.libsvm');
format long
nRows = size(A_instance_matrix,1);
nCols = size(A_instance_matrix,2) + 1;
t = (A_label_vector./2) -1;
theta = [ones(nRows,1) A_instance_matrix];
w = zeros(nCols,1);
R = zeros(nRows,nRows);
epochs = 10;
xAxis = zeros(epochs,1);
yAxis = zeros(epochs,1);
%% reweighting starts
for j = 1:epochs
    y = sigmf((theta * w),[1 0]);
    for i = 1:nRows
        b = y(i,1);
        R(i,i) = b*(1-b);
    end
    w = w - ((theta' *R* theta) \ (theta' *(y - t)));
    xAxis(j,1) = j;
    costFun = (-t.*log(y) - (1-t).*log(1-y));
    yAxis(j,1) = sum(costFun);
end
%%
plot(xAxis,yAxis);
xlabel('number of epochs'); % x-axis label
ylabel('value of cost function'); % y-axis label
title('iterative reweighting least squares for logistic regression');
y = sigmf((theta * w),[100 0]);% 100 to get exact value 0 or 1
incorrect = ceil(sum((t-y).*(t-y)));
fprintf('Wrong results = %d \nAccuracy = %f percent\n',incorrect,(1-(incorrect/nRows))*100);


