function [lbp dct structural] = ExtractFeatures(input, n)
%Extracts the LBP, structural and DCT features from the input vector.
%The default DCT matrix size selected is 5 x 5,if this is to be changed
%then alter dctvec() to dctvec(1:7,1:7);
%n is the size needed for the vec2mat function. Splits the single row vector into a matrix with 
% that many columns.
Horz = 0;
Vert = 0;
[r c] = size(input);

for k = 1:c
    temp2 = vec2mat(input(:,k),n);
    temp2 = temp2';
    
    
    %Feature 1 -LBP histogram
 %extracting local binary pattern for features
 %since image is already in binary form, the lbp function cannot be used
 temp3 = padarray(temp2, [1,1]); % padded array with zeroes
 temp6 = zeros(50,50);
 histo = zeros(256,1);
 
 for i = 2:51
     for j = 2:51
         b = [temp3(i-1,j-1) temp3(i-1,j) temp3(i-1,j+1) temp3(i,j+1) temp3(i+1,j+1) temp3(i+1,j) temp3(i+1,j-1) temp3(i,j-1)];
         dec = b(1)*128 + b(2)*64 + b(3)*32 + b(4)*16 + b(5)*8 + b(6)*4 + b(7)*2 + b(8);
         temp6(i-1,j-1) = dec;
         % to form a histogram with 256 bins
         for m = 0:255
             if temp6(i-1,j-1) == m
                 histo(m+1,1) = histo(m+1,1) + 1;
             end
         end
                 
                 
     end
 end
 
histvec(:,k) = histo;
    
    
    
    
    
    
    
    
    %Feature 2 - Area of character
cnt = 0;
for i=1:50
    for j = 1:50
        if temp2(i,j) == 0
            cnt = cnt+1;
        end
    end
end
Area(:,k) = cnt;
clear cnt;
%Need to normalize the area parameter so that it doesnt overpower any other
%features

    
    
    
    
    
    
for i = 1:50
    cnt=0;
    for j = 1:50
        if temp2(i,j) == 0
            cnt = cnt+1;
        end
        Horz(i,k) = cnt;
    end
end
%Vertical Projection
for j = 1:50
     cnt=0;
    for i =1:50
       
        if temp2(i,j) == 0
            cnt = cnt+1;
        end
        Vert(j,k) = cnt;
    end
end

% %Feature 3 -Centroid of character area
[a b] = ait_centroid(temp2);
Centvec(1,k) = a;
Centvec(2,k) = b;

eulervec(1,k) = bweuler(temp2);

%Feature 6 - Perimeter of the connected object
cnt =0;
edgeimage = edge(temp2,'sobel');

for i = 1:50
    for j =1:50
        if edgeimage(i,j) == 1
            cnt = cnt+1;
        end
    end
end

Perimeter(:,k) = cnt;
clear cnt; clear edgeimage;

%Feature 7 - Thinness ratio 4*pi*Area/Perimeter^2
thin(:,k) = (4*pi*Area(:,k))/((Perimeter(:,k))^2);


%Feature 8 - Extent - Ratio of 'on' area / total area of image

extent(:,k) = Area(:,k)/2500;


%Extracting the DCT features of the images

  


        dct = dct2(temp2);
        dct = dct(1:5,1:5);
        dctx = dct(:);
        dctvec(:,k) = dctx;












end

 structural = [Area;Horz;Vert;Centvec;eulervec;Perimeter;thin;extent];
for i=1:256
    histvec(i,:) = histvec(i,:) / max(histvec(i,:));
end


 lbp = histvec;
 lbp = lbp(isfinite(lbp(:, 1)), :);
dct = dctvec;


end
