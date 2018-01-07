function [class3] = knn2(Training, label2, Testing,n)
%This function takes the Training data, training labels, testing data and
%'n' nearest neighbour number as parameters, and applies the KNN algorithm
%on it.
%The last few lines can be uncommented to calculate the accuracy.



%knn
[r c] = size(Testing);
[a b] = size(Training);
cnt =0;

%decide number of nearest neighbours to take




for i = 1 : c  %for every test image
   for j = 1:b % test it with every training image
       dist(i,j) = sum((Testing(:,i) - Training(:,j)).^2);
   end
end


cnt = zeros(1,j);
for i = 1:c %for every test image
    [sorted index] = sort(dist(i,:));
    sorted2 = sorted(1:n);
    category = ceil(index(1:n)/38);
    testbin = zeros(1,26);
    for j = 1:n
        testbin(category(j)) = testbin(category(j)) + 1;
    end
    [val ind] = max(testbin);
    class3(i) = ind;
end
        
    
   
    
%     
%   err = class3 - label;
% 
% count = 0;
% for i = 1: numel(err)
%     if err(i) == 0
%         count = count+1;
%     end
% end
% acc = count*100/numel(err);

end
        



    
            
        
        
        

