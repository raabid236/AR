%Autonomous Robots
%Lab 1: Potential Functions
%Author: Raabid Hussain
%This script calls both the potential functions and displays their results
%Note: If you want to load a map, simply uncomment line 30 and write the
%name of the file there

clear all;
close all;
clc;

start=[13 2];
goal=[3 18];

%Self created map
map=[
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 0 0 0 1;
1 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 1;
1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1;
1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 1;
1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1;
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;];

%Uncomment and write the file name in the next line to load a map
%load ('obstaclesBig.mat')

%Displays the map
figure;
imshow(map);
title('Original Map');

%Calls the brushfire algortihm and displays its results
[value_map]=brushfire(map);
value_map=1-(value_map/max(max(value_map)));
figure;
imshow(value_map);
title('Potential Function Brushfire');
figure;
meshc(value_map)
title('Potetial Brusfire 3D');

%Calls the wavefront algortihm and displays its results
%Change the starting and goal position according to the map
[value_map, trajectory]=wavefront(map, start, goal);
figure;
value_map=1-(value_map/max(max(value_map)));
imshow(value_map);
title('Potential Function Wavefront');
figure;
meshc(value_map);
title('Potential 3D Wavefront');
figure;
path=1-map/2;
%Displays the trajectory calculated
for i=1:size(trajectory)
    path(trajectory(i,1),trajectory(i,2))=0;
end
imshow(path);
title('Path Wavefront');



