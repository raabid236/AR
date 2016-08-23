%Autonomous Robots
%Lab 4: A Star Algorithm
%Author: Raabid Hussain
%This function contains the code for the A* algorithm to find the optimal
%path provided the visibiltiy graph for the map
%Inputs: list of vertices and edges in the visibility graph
%Outputs: A list containing all the nodes in the optimal path found and its
%corresponding distance

function [path, minCost] = Astar(vertices,edges)
    %initializations
    path = [];
    minCost = 0;
    %closed list
    clist=[];
    %number of vertices
    [m,~]=size(vertices);
    %sparse affinity matrix contating all the distance for each edge
    distance = zeros(m);

    %computing distances for each edge
    for i=1:size(edges,1)
        distance(edges(i,1),edges(i,2))=sqrt((vertices(edges(i,1),1)-vertices(edges(i,2),1)).^2 + (vertices(edges(i,1),2)-vertices(edges(i,2),2)).^2);
        distance(edges(i,2),edges(i,1))=distance(edges(i,1),edges(i,2));
    end
    %computing heuristic distance for each vertex (from current noe to the goal)
    for i=1:size(vertices,1)
        heuristic(i,:)=sqrt((vertices(i,1)-vertices(end,1)).^2 + (vertices(i,2)-vertices(end,2)).^2);
    end

    % Distance from start along the best path found so far
    final_dist = zeros(1, size(edges,1));
    % Prediction of the total cost for the path
    dist = zeros(1, size(edges,1));
  	dist(1) = final_dist(1) + heuristic(1);
    % Open list
    olist = [dist(1) 1];
    % List of all the evaluated nodes so far
    prev = zeros(1, size(edges,1));

    %loop to find the optimal path
    while ~isempty(olist)
        % sorting the open list in ascending order of each nodes distance
        olist = sortrows(olist,1);
        % Least distance node in the open list
        cur = olist(1, :);
        
        %termination condition
        %Optimal path found (goal vertex enters the closed list)
        if cur(1, 2) == m
            %finding all the nodes in the optimal path
            path = [m];
            while (1)
                if prev(m) == 0
                    break;
                end
                m = prev(m);
                path = [m path];
            end
            %Distance for the optimal path
            minCost = dist(cur(1, 2));
            
            %drawing the obstacles
            % starting position 
            plot( vertices(1,1), vertices(1,2), 'r*','MarkerSize', 10);
            hold on;
            % last/goal position
            plot( vertices((size(vertices,1)),1), vertices(size(vertices,1),2), 'k*','MarkerSize', 10);
            % obstacle lines
            for i=1:size(edges,1)
                plot([vertices( edges(i,1), 1); vertices( edges(i,2), 1)],[vertices( edges(i,1), 2); vertices( edges(i,2), 2)], 'Color', 'b');
            end
            % draw edges
            for i = 2: size(path, 2)
                plot([vertices(path(i-1), 1), vertices(path(i), 1)], [vertices(path(i-1), 2), vertices(path(i), 2)], 'Color', 'g');
            end
            return;
        end
        
        %adding the first node in the open list to th eclosed list
        clist = [clist; cur];
        % removing the first element (current node) in the open list as it has been added
        % into the lcosed list
        olist(1, :) = [];
        % finding all the connected nodes for the current node
        edg = cur(1, 2);
        connected = find(distance(edg, :));

        %loop for updating the open list
        for k = 1: size(connected,2)
            ind = connected(k);
            %predicting the distance for the path
            temp = final_dist(edg) + distance(cur(1, 2), ind);
            %if the new node is already in the closed list
            if ~isempty(find(clist==ind)) 
                %if the new distance is larger than the already added
                %distance, do nothing (dont replace)
                if temp >= final_dist(ind)
                    continue;
                end
            end
            %if the new node is not in the open list or the new distance is
            %lesser tahn the already added one, add the node to the lists
            if isempty(find(olist==ind)) || temp < final_dist(ind)
                prev(ind) = cur(1, 2);
                final_dist(ind) = temp;
                dist(ind) = final_dist(ind) + heuristic(ind);
                if isempty(find(olist==ind))
                    % adding the connected node to the open list
                    olist = [olist; dist(ind) ind];
                end
           end
        end
    end
end