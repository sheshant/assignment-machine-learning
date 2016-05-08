[A_label_vector, A_instance_matrix] = libsvmread('breast-cancer.libsvm');
format long
A_instance_matrix(:,1) = A_instance_matrix(:,1)/1000000;% can't find a possible explanation behind doing this
nRows = size(A_instance_matrix,1);
nCols = size(A_instance_matrix,2) + 1;
t = (A_label_vector./2) -1;
theta = [ones(nRows,1) A_instance_matrix];
w = zeros(nCols,1);
alpha = 0.01;
epochs = 20;
xAxis = zeros(epochs,1);
yAxis = zeros(epochs,1);
%% loop 
for j = 1:epochs
    for i = 1:nRows
        hypothesis = sigmf((theta(i,:) * w),[1 0]);
        y = t(i,:);
        x = theta(i,:);
        gradient = (hypothesis-y)*x;
        % calculate the cost
        w = w - (alpha*gradient)';
    end
    hypothesis = sigmf((theta * w),[1 0]);
    costFun = (-t.*log(hypothesis) - (1-t).*log(1-hypothesis));
    xAxis(j,1) = j;
    yAxis(j,1) = sum(costFun);
end
%% plot
plot(xAxis,yAxis);
xlabel('number of epochs'); % x-axis label
ylabel('value of cost function'); % y-axis label
title('stochastic gradient descent for logistic regression');
y = sigmf((theta * w),[100 0]);% 100 to get exact value 0 or 1
incorrect = ceil(sum((t-y).*(t-y)));
fprintf('Wrong results = %d \nAccuracy = %f percent\n',incorrect,(1-(incorrect/nRows))*100);