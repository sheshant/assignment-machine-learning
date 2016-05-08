[A_label_vector, A_instance_matrix] = libsvmread('breast-cancer.libsvm');
combined = [A_label_vector A_instance_matrix]; % we will need it 
data_size = size(combined,1);
format long

%% k_fold start here
k_fold = [3 5 10];
for k = k_fold
    new_cell = random_divide(combined,k);
    %%  now we got random k chunks 
    %   we need to combine all but one chunk and separate label vector and
    %   instance matrix from it 
    fprintf('For k = %d\n',k);
    for i = 1:k
        error = 0;
        train = zeros(0);
        test = zeros(0);
        for j = 1:k
            if(j == i)
                test = new_cell{i};
            else
                train = [train;new_cell{i}];
            end
        end
        test_data_size = size(test,1);
        [Y,I]=sort(train(:,1));
        train = train(I,:);
        clearvars I Y
        % for sub part, we need to get occurence of 2
        prob2 = nnz(train(:,1) == 2)/size(train(:,1),1);
        prob4 = nnz(train(:,1) == 4)/size(train(:,1),1);
        
        count = nnz(train(:,1) == 2);
        label_vector_train1 = train((1:count),1);
        instance_matrix_train1 = train((1:count),(2:end));
        label_vector_train2 = train((count+1:end),1);
        instance_matrix_train2 = train((count+1:end),(2:end));
        label_vector_test = test(:,1);
        instance_matrix_test = test(:,(2:end));
        
        %% and we got train and test dataset
        % get mean and variance and also probability
        mean_value1 = mean(instance_matrix_train1);
        standard_dev1 = std(instance_matrix_train1);
        mean_value2 = mean(instance_matrix_train2);
        standard_dev2 = std(instance_matrix_train2);
        
        %% we got mean and standard dev now start testing 
        for loop = 1:size(label_vector_test,1)
            p2 = prob2;
            p4 = prob4;
            p2 = [p2 normpdf(instance_matrix_test(loop,:),mean_value1(1,:),standard_dev1(1,:))];
            p4 = [p4 normpdf(instance_matrix_test(loop,:),mean_value2(1,:),standard_dev2(1,:))];
            
            if(prod(p2) > prod(p4))
                if((2 - label_vector_test(loop)) ~= 0)
                    error = error+1;
                end
            else
                if((4 - label_vector_test(loop)) ~= 0)
                    error = error+1;
                end
            end
            
        end
        fprintf('Test dataset %d:\t\terror = %d \t\tAccuracy = %f percent\n',i, error,(1-(error/test_data_size))*100);
    end
end