function [map]=brushfire(map)
%brushfire algorithm
%input: map
%ouput: potentials
%calculates the size of the map
    [m,n]=size(map);
%label for representing potentials    
    pot=1;
%loop to calulate potentials    
    while(1)
%check if all the pixels have been assigned a potential
       loop=0;
       for i=2:m-1
           for j=2:n-1
%if the pixel has not been assigned a label yet
               if map(i,j)==0
%check the neighborhood to assign label                   
                   if map(i+1,j)==pot | map(i-1,j)==pot | map(i,j-1)==pot | map(i,j+1)==pot | map(i-1,j-1)==pot | map(i-1,j+1)==pot | map(i+1,j-1)==pot | map(i+1,j+1)==pot
                       map(i,j)=pot+1;
                       loop=1;
                   end
               end
           end
       end
%all pixels labelled?       
       if loop==0
           break;
       end
%increment label value
       pot=pot+1;
    end



