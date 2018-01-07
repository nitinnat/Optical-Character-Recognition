function [result] = multisvm(Training,Group,Test)
%Applies One-Vs-All SVM on the Training data, and classifies the test
%vector and returns the classes.

u=unique(Group);
num=length(u); %number of classes
result = zeros(length(Test(:,1)),1);


options = statset('MaxIter', 100000);
for k=1:num
    %Labels or groups need to have a binarised form, as the below statement
    %does.
    OneVall=(Group==u(k));
    mod(k) = svmtrain(Training,OneVall, 'options', options);
end

%classify test cases
for j=1:size(Test,1)
    for k=1:num
        if(svmclassify(mod(k),Test(j,:))) 
            break;
        end
    end
    result(j) = k;
end