% Variables
global N                
global n
global p
global m_start

N = 1000;       % number of repeats
n = 10;         % number of games per repeat
p = 60;         % winning probability (in %, 0 - 100)
m_start = 100;  % start amount of money

% Players
global bet_1            
global bet_2 
global score_1  
global score_2   
global history_1     
global history_2   
global win_1 
global win_2

bet_1 = zeros(N,1);         % bet player 1 (in %)
bet_1(1,1) = 10;            % starting bet player 1 (in %)
bet_2 = zeros(N,1);         % bet player 2 (in %)
bet_2(1,1) = 20;            % starting bet player 2 (in %)
score_1 = zeros(N,n+1);     % scores of player 1 in one repeat
score_2 = zeros(N,n+1);     % scores of player 2 in one repeat
history_1 = zeros(N,n);     % win (=1) / lose (=0) history of player 1 in one game (random)
history_2 = zeros(N,n);     % win (=1) / lose (=0) history of player 2 in one game (random)    
win_1 = zeros(N,1);         % win (=1) / lose (=0) history of player 1 in one repeat   
win_2 = zeros(N,1);         % win (=1) / lose (=0) history of player 2 in one repeat

% Game
for i = 1:1:N
    score_1(i,1) = m_start;         % first entry = start value
    score_2(i,1) = m_start;         % first entry = start value
    
    for j = 2:1:n+1
% game for player 1
        rand_Nb_1 = randi(100);
        if rand_Nb_1 <= p           % win
            score_1(i,j) = score_1(i,j-1) + bet_1(i,1)/100*score_1(i,j-1);
            history_1(i,j) = 1;
        else                        % lose
            score_1(i,j) = score_1(i,j-1) - bet_1(i,1)/100*score_1(i,j-1);
            history_1(i,j) = 0;  
        end
% game for player 2
        rand_Nb_2 = randi(100);
        if rand_Nb_2 <= p           % win
            score_2(i,j) = score_2(i,j-1) + bet_2(i,1)/100*score_2(i,j-1);
            history_2(i,j) = 1;
        else                        % lose
            score_2(i,j) = score_2(i,j-1) - bet_2(i,1)/100*score_2(i,j-1);
            history_2(i,j) = 0;
        end
    end
            
% Evaluation & strategy change
    % player 1 wins
if score_1(i,n+1) > score_2(i,n+1)              
    
    win_1(i,1) = 1;                             % update winner history
    win_2(i,1) = 0;
    
    bet_2(i+1,1) = bet_1(i,1);                  % loser adapts the strategy of the winner
    
    if randi(100) > 50 && bet_1(i,1) > 5        % new random strategy for the winner
        bet_1(i+1,1) = bet_1(i,1)-randi(5);
    else bet_1(i+1,1) = bet_1(i,1)+randi(5);
    end
    
    % player 2 wins
elseif score_2(i,n+1) > score_1(i,n+1)          
    
    win_1(i,1) = 0;                             % update winner history
    win_2(i,1) = 1;
    
    bet_1(i+1,1) = bet_2(i,1);                  % loser adapts the strategy of the winner
    
    if randi(100) > 50 && bet_2(i,1) > 5        % new random strategy for the winner
        bet_2(i+1,1) = bet_2(i,1)-randi(5);
    else bet_2(i+1,1) = bet_2(i,1)+randi(5);
    end
    
    % draw --> keep strategy
else    
    win_1(i,1) = 0;
    win_2(i,1) = 0;
end
end

sum_1 = sum(win_1);
sum_2 = sum(win_2);

%Plots of scores
figure(1);
plot(1:N,score_1(:,11))
hold on
plot(1:N,score_2(:,11),'red')

%Plots of bets
figure(2);
plot(1:N+1,bet_1(:,1))
hold on
plot(1:N+1,bet_2(:,1),'red')

%Results:

%bet_1
%bet_2
%score_1
%score_2
%history_1
%history_2
%win_1
%win_2        
        
        