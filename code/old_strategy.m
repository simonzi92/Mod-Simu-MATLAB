% This m-file contains the Evaluation & strategy change for both players as
% a first version / assumption

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