%this file comprises the RRT algorithm

function [vertices,edges,path]=rrt(map,q_start,q_goal,num,delta_q,p)
    %displaying the map of the environment
    figure;
    colormap=[1 1 1; 0 0 0; 1 0 0; 0 1 0; 0 0 1];
    imshow(uint8(map),colormap)
    hold on

    %size of the environemnt
    [m,n]=size(map);
    %initializing the vertices list
    vertices(1,:)=q_start;
    %loop to generate tree
    %Note:while loop was used as the for loop was giving me errors when changing
    %the counter value within the loop
    i=1;
    while(i<=num)
        %generating a random sample point
        while(1)
            %biasing the sample point
            new=rand(1);
            %new random point
            if new>p
                x=round(rand(1)*m);
                y=round(rand(1)*n);
                if x>0 && y>0
                    if map(x,y)==0
                        break;
                    end
                end
            %goal position as random point
            else
                y=q_goal(1,1);
                x=q_goal(1,2);
                break;
            end
        end
        %finding the nearest node
        [o,~]=size(vertices);
        dist=inf;
        for j=1:o
            distn=sqrt((vertices(j,1)-y)^2 + (vertices(j,2)-x)^2);
            if distn<dist
                dist=distn;
                q_near=j;
            end
        end
        %producing a point according to the delta_q distance parameter
        if dist>delta_q
            dist=delta_q;
        end
        %checking if the connection is in free space
        check=0;
        mdist=0:5:dist;
        theta=atan2(x-vertices(q_near,2),y-vertices(q_near,1));
        x=round(mdist*sin(theta)+vertices(q_near,2));
        y=round(mdist*cos(theta)+vertices(q_near,1));
        for k=1:size(x,2)
            if map(abs(x(k)),abs(y(k)))==1 
                check=1;
                break;
            end
        end
        %creating the connection point
        x=round(dist*sin(theta)+vertices(q_near,2));
        y=round(dist*cos(theta)+vertices(q_near,1));
        %check to see if the point is valid
        if check==1 || map(abs(x),abs(y))==1
            continue;
        end
        %updating the vertices and edges list
        vertices(i+1,:)=[y x];
        edges(i,:)=[q_near i+1];
        %termination condition
        if x==q_goal(2) && y==q_goal(1)
            break;
        end
        %increment counter to see if maximum number of iterations reached
        i=i+1;
    end
    %if no path found
    if i==1001
        print('The path could not be found');
        return
    end
    %displayong the tree produced
    plot(q_start(1),q_start(2),'k*','MarkerSize', 10);
    plot(q_goal(1),q_goal(2),'b*','MarkerSize', 10);
    for i=1:size(edges,1)
        plot([vertices( edges(i,1), 1); vertices( edges(i,2), 1)],[vertices( edges(i,1), 2); vertices( edges(i,2), 2)],'r');
    end
    
    %finding the path between the start and goal positions
    k=1;
    path(k)=edges(end,2);
    while(1)
        if path(k)==1
            break;
        end
        for j=1:i
            if (edges(j,2)==path(k))
                k=k+1;
                path(k)=edges(j,1);
                break;
            end
        end
    end
    %craeting a list of branches forming the path
    for i=1:size(path',1)-1
        drawp(i,:)=[path(i) path(i+1)];
    end
    %displaying the path
    for i=1:size(drawp,1)
        plot([vertices( drawp(i,1), 1); vertices( drawp(i,2), 1)],[vertices( drawp(i,1), 2); vertices( drawp(i,2), 2)],'g');
    end
    %sorting the path variable to be as asked in lab description file
    path=sort(path);
end