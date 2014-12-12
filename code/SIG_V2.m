% SKRIPTMASTER: Sequential Investment Game for two Players
%
% This script contains the code of the Sequential Investment Game for two
% players, which is part of the GESS course "Modelling and Simulating Social
% Systems with MATLAB".
%
% Authors: Fabian Keller, Sebastian Klotz, Simon Zimmermann
% Date: 25.11.2014
% Version 2

clear all
close all
clc

% Variable definition

c = 100;                    % number of repeats
C = 100;                    % number of games
n = 10;                     % number of turns

m_start = 100;              % starting money
p = 60;                     % probability of winning in %

s_pool = 10:2.5:30;         % pool of bets

strategy_1 = zeros(1,n);    % strategies: 10x bet
strategy_2 = zeros(1,n);
win_1 = zeros(1,2);         % wins | uses - per strategy
win_2 = zeros(1,2);
money_1 = zeros(1);         % money
money_2 = zeros(1);

% start strategy
for l = 1:1:n
    strategy_1(1,l) = s_pool(randi(length(s_pool)));
end
for l = 1:1:n
    strategy_2(1,l) = s_pool(randi(length(s_pool)));
end

% SIG
for i = 1:1:C
    
    % round
    for j = 1:1:c
                
        money_1(end) = m_start;
        money_2(end) = m_start;
                
        % turn
        for k = 1:1:n
                       
           % player 1
           if randi(100) <= p
               money_1(end) = money_1(end) + money_1(end)*strategy_1(end,k)/100;
           else
               money_1(end) = money_1(end) - money_1(end)*strategy_1(end,k)/100;
           end
           
           % player 2
           if randi(100) <= p
               money_2(end) = money_2(end) + money_2(end)*strategy_2(end,k)/100;
           else
               money_2(end) = money_2(end) - money_2(end)*strategy_2(end,k)/100;
           end
           
        end
        
        % Who has won?
        if money_1(end) > money_2(end)
            win_1(end,1) = win_1(end,1) + 1;
        elseif money_1(end) < money_2(end)
            win_2(end,1) = win_2(end,1) + 1;
        end
        
    end
    
    % strategy change
    if win_1(end,1) > win_2(end,1)
        % player 2 change
        win_2(end+1,1) = 0;
        money_2(end+1) = 0;
        strategy_2(end+1,:) = 0;
        for l = 1:1:n
            strategy_2(end,l) = s_pool(randi(length(s_pool)));
        end
    elseif win_1(end,1) < win_2(end,1)
        % player 1 change
        win_1(end+1,1) = 0;
        money_1(end+1) = 0;
        strategy_1(end+1,:) = 0;
        for l = 1:1:n
            strategy_1(end,l) = s_pool(randi(length(s_pool)));
        end
    end
    
    % counter reset
    win_1(end,1) = 0;
    win_2(end,1) = 0;
    
    % number of rounds a strategy has been used
    win_1(end,2) = win_1(end,2) + 1;
    win_2(end,2) = win_2(end,2) + 1;
    
end

disp('Finished.')
disp(' ')
disp('Number of loops done:')
i*j*k

disp(' ')
disp('Analysis of strategies:')
disp(' ')

% strategy used the most:
[max_val_1,max_ind_1] = max(win_1(:,2));
[max_val_2,max_ind_2] = max(win_2(:,2));
disp('Strategies used the most:')
disp(' ')
disp('Player 1')
Strategy = strategy_1(max_ind_1,:)
used = max_val_1
disp('Player 2')
Strategy = strategy_2(max_ind_2,:)
used = max_val_2
disp(' ')
disp('end')

% order arrays and imagesc strategies
[sort_val_1,sort_ind_1] = sort(win_1(:,2), 'descend');
[sort_val_2,sort_ind_2] = sort(win_2(:,2), 'descend');

% Plot of strategies
figure(1)
subplot(1,2,1)
imagesc(strategy_1(sort_ind_1(1:10),:))
title('Plot of top strategies of player 1');
xlabel('Number of bets');
ylabel('Strategies');
colorbar
subplot(1,2,2)
imagesc(strategy_2(sort_ind_2(1:10),:))
title('Plot of top strategies of player 2');
xlabel('Number of bets');
ylabel('Strategies');
colorbar

% END OF SIG_V2
