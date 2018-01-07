function [train, test] = TrainAndTest(features)
no_train = 38; %approx 70% of 55
no_test = 17;
%training data
t = 55;
for i = 1:26
    train(:,no_train*(i-1)+1 : no_train*(i-1)+no_train) = features(:,t*(i-1)+1 : t*(i-1)+no_train);
%     training_targets(:,no_train*(i-1)+1 : no_train*(i-1)+38) = label(:,t*(i-1)+1 : t*(i-1)+no_train);
end

%testing data approx 30% 
for i = 1:26
    test(:, no_test*(i-1)+1 : no_test*(i-1) + 17) = features(:,(i-1)*t + 39 : i*t);
%     testing_targets(:, no_test*(i-1)+1 : no_test*(i-1) + 17) = label(:,(i-1)*t + 39 : i*t);
end

end

