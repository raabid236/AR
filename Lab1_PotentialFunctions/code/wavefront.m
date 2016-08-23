function [map, traj] = wavefront(map, s, g)
%brushfire algorithm
%input: map, starting position, goal position
%output: potentials, trajectory
%transforming input into convenient variables used in the rest of the code
    sr=s(1,1);
    sc=s(1,2);
    gr=g(1,1);
    gc=g(1,2);
%calculates the size of the map
    [m,n]=size(map);
%assigns potential value to starting position    
    map(sr,sc)=2;
%label for representing potentials    
    pot=2;
%loop to calulate potentials    
    while(1)
%check if all the pixels have been assigned a potential
        loop=0;
        for i=2:m-1
            for j=2:n-1
%if the pixel has not been assigned a label yet
                if (map(i,j))==0
%check the neighborhood to assign label                   
                   if map(i+1,j)==pot | map(i-1,j)==pot | map(i,j-1)==pot | map(i,j+1)==pot | map(i-1,j-1)==pot | map(i-1,j+1)==pot | map(i+1,j-1)==pot | map(i+1,j+1)==pot
                       map(i,j)=pot+1;
                       loop=1;
                   end
                end
            end
        end
%all pixels labelled?       
        if (loop==0)
            break;
        end
%increment label value
        pot=pot+1;
    end

%determining trajectory: starting form goal    
    traj=[gr,gc];
    while(1)
%reached starting position?
        if map(traj(1,1),traj(1,2))==2
            break;
%checking for a connection: preference given to 90 degrees
        elseif map(traj(1,1)-1,traj(1,2))==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)-1,traj(1,2);traj];
        elseif map(traj(1,1)+1,traj(1,2))==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)+1,traj(1,2);traj];
        elseif map(traj(1,1),traj(1,2)+1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1),traj(1,2)+1;traj];
        elseif map(traj(1,1),traj(1,2)-1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1),traj(1,2)-1;traj];
        elseif map(traj(1,1)-1,traj(1,2)-1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)-1,traj(1,2)-1;traj];
        elseif map(traj(1,1)+1,traj(1,2)-1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)+1,traj(1,2)-1;traj];
        elseif map(traj(1,1)-1,traj(1,2)+1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)-1,traj(1,2)+1;traj];
        elseif map(traj(1,1)+1,traj(1,2)+1)==map(traj(1,1),traj(1,2))-1
            traj=[traj(1,1)+1,traj(1,2)+1;traj];
        else
            break;
        end
    end
    



