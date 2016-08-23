%Auonomous Robots
%Raabid Hussain
%Q-Learning Algorithm
%This function computes the path using Q_learning algorithm
%Output: Optimal policy for each cell
%Input: map, goal position, learning rate, discount factor, random
%probability, number of episodes, number of iteations

function [Q] = q_learning(map,q_goal,alpha,gamma,epsilon,n_episodes,n_iterations)
%size of the map
[m,n]=size(map);
%Initialize Effectiveness
TR=zeros(1,ceil(n_episodes/200));
%initialize Q(s,a)
% left:1, up:2, right:3, down:4
for i=1:4
    Q(:,:,i)=zeros(m,n);
end
%Q_learning loop
for i=1:n_episodes
    %Initialize s randomly
    while(1)
        s=[ceil(rand(1)*m), ceil(rand(1)*n)];
        if map(s(1),s(2))==0 && ~(s(1)==q_goal(2) && s(2)==q_goal(1))
            break;
        end
    end
    for j=1:n_iterations
        %epsilon greedy action
        if rand(1)>epsilon
            [~,a]=max(Q(s(1),s(2),:));
        else
            a=ceil(rand(1)*4);
        end
        %s' (new s)
        switch(a)
            case 1
                s1=s-[0,1];
            case 2
                s1=s-[1,0];
            case 3
                s1=s+[0,1];
            otherwise
                s1=s+[1,0];
        end
        %observe reward
        if s1(1)==q_goal(2) && s1(2)==q_goal(1)
            r=1;
        else
            r=-1;
            %if new cell is an obstacle stay in original cell
            if map(s1(1),s1(2))==1
                s1=s;
            end
        end
        %update Q
        Q(s(1),s(2),a)=Q(s(1),s(2),a)+alpha*(r+gamma*(max(Q(s1(1),s1(2),:)))-Q(s(1),s(2),a));
        %update s
        s=s1;
        %updating effectiveness
        TR(ceil(i/200))=TR(ceil(i/200))+r/200;
        %goal reached: break the episode
        if r==1
            break;
        end
    end
end

%display state value function for all directions
Q
%plot effectiveness graph
figure;
plot(TR);


%determinating optimal policy
for i=1:m
    for j=1:n
        %taking maximum values' action
        [Q2(i,j), a]=max(Q(i,j,:));
        %no movement in goal and obstacles
        if map(i,j)==1 || (i==q_goal(2) && j==q_goal(1))
            Qfinal(i,j)='o';
        else
            %assigning directions
            switch a
                case 1
                    Qfinal(i,j)='<';
                case 2
                    Qfinal(i,j)='^';
                case 3
                    Qfinal(i,j)='>';
                otherwise
                    Qfinal(i,j)='v';
            end
        end
    end
end

%plotting state value function
Q2
figure;
Q2=flipud(Q2);
Q2=[Q2 Q2(:,end)];
Q2=[Q2; Q2(end,:)];
pcolor(Q2);



%displaying optimal policy
Qfinal