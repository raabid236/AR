%this file comprises the smoothing function for RRT algo

function [path_smooth]=smooth(map,path,vertices,delta)
    %displaying the map of the environemnt
    figure;
    colormap=[1 1 1; 0 0 0; 1 0 0; 0 1 0; 0 0 1];
    imshow(uint8(map),colormap)
    hold on

    %finding the path list from output of the RRT function
    for i=1:size(path',1)-1
        drawp(i,:)=[path(i) path(i+1)];
    end
    %displaying the nodes in the path
    for i=1:size(path')
        plot(vertices( path(i), 1), vertices( path(i), 2),'bo','MarkerSize', 4);
    end
    %displaying the path form RRT
    for i=1:size(drawp,1)
        plot([vertices( drawp(i,1), 1); vertices( drawp(i,2), 1)],[vertices( drawp(i,1), 2); vertices( drawp(i,2), 2)],'r');
    end
    
    %smmothing the path
    i=1;
    path_smooth=[i];
    while(1)
        %checking all previous points in the path
        for j=size(path,2):-1:i
            %generating points on the line formed by the two nodes
            check=0;
            r=sqrt((vertices(path_smooth(end),1)-vertices(path(j),1)).^2+(vertices(path_smooth(end),2)-vertices(path(j),2)).^2);
            theta=atan2((vertices(path(j),2)-vertices(path_smooth(end),2)),(vertices(path(j),1)-vertices(path_smooth(end),1)));
            dist=0:delta:r;
            x=round(dist*sin(theta)+vertices(path_smooth(end),2));
            y=round(dist*cos(theta)+vertices(path_smooth(end),1));
            %checking if connection is free
            for k=1:size(x,2)
                if map(abs(x(k)),abs(y(k)))==1 
                    check=1;
                    break;
                end
            end
            %adding nodes to the smooth path variable
            if (check==0)
                path_smooth=[path_smooth path(j)];
                i=j;
                break;
            end
        end
        %termination condition for the loop
        %smooth path found
        if (path_smooth(end)==path(end))
            break;
        end
    end
    
    %finding connections between nodes of the smooth path
    drawp=[];
    for i=1:size(path_smooth',1)-1
        drawp(i,:)=[path_smooth(i) path_smooth(i+1)];
    end
    %displaying the smoothed path
    for i=1:size(drawp,1)
        plot([vertices( drawp(i,1), 1); vertices( drawp(i,2), 1)],[vertices( drawp(i,1), 2); vertices( drawp(i,2), 2)],'g');
    end
    
    
    
    
    
end