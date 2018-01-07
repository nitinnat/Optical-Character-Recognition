
load('FeatureVectors.mat');
[r c] = size(lbp);
[train,  test] = TrainAndTest(dct);
label_train = ones(1,38);
label_test = ones(1,17);
for i = 2:26
    label_train = horzcat(label_train, i*ones(1,38));
    label_test = horzcat(label_test, i*ones(1,17));
end
%   [class acc] = knn2(train,label_train,test,label_test,3);
%  acc
  [class] = knn2(train,label_train,test,3);
  
  %     
  err = class - label_test;

count = 0;
for i = 1: numel(err)
    if err(i) == 0
        count = count+1;
    end
end
acc = count*100/numel(err);

%    for i = 1:442
% %        sortclass = sort(class(i,:)); %sorting the knn obtained classes of each test image
%        svminput = train(:,class(i,:));
%        templabel = ceil(class(i,:)/38);
%        if(numel(unique(templabel)) > 1)
%        tempclass = multisvm2(svminput',templabel',(test(:,i))');
%        u = unique(templabel);
%        class4(i) = u(tempclass);
%        
%        else
%            class4(i) = templabel(1);
%        end
%        
%    end
%    
%    err = class4 - label_test;
% 
% count = 0;
% for i = 1: numel(err)
%     if err(i) == 0
%         count = count+1;
%     end
% end
% acc = count*100/numel(err) 

%To form confusion matrix
confmat = zeros(26,26);
 for i = 1: x
     confmat(class(1,i),label_test(1,i)) = confmat(class(1,i),label_test(1,i)) + 1;
 end
 confmat = confmat';
