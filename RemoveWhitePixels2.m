function [extra] = RemoveWhitePixels2( r, c , bin)
%Function to remove unnecessary white pixels
%The function first takes the convex hull and then finds
%ymin,ymax,xmin,xmax fo the object in the image.
hull2 = bwconvhull(imcomplement(bin));
hull = imcomplement(hull2);

% xmin = 1; xmax = c; ymin = 1; ymax = r;
 cnt = 1;
 a=1;
 k=1;
 while(a==1)
    
     if hull(k,:)==ones(1,c) 
         k = k+1;
     else
         
         ymin = k;
         a=0;
     end
    
 end
 
 a=1;
 k=r;
 while(a==1)
   
     if hull(k,:) == ones(1,c) 
         k = k-1;
     else
         
         ymax = k;
         a=0;
     end
    
 end
 
 a=1;
 k=1;
 while(a==1)
     
     if hull(:,k)==ones(r,1) 
         k = k+1;
     else
         
         xmin = k;
         a=0;
     end
     
 end
 
 a=1;
 k=c;
 while(a==1)
     
     if hull(:,k)==ones(r,1) 
         k = k-1;
     else
         
         xmax = k;
         a=0;
     end
     
 end

 coords = [xmin xmax ymin ymax];
 extra =  [bin(ymin:ymax,xmin:xmax)];


end

