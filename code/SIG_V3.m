% SKRIPTMASTER: Sequential Investment Game for two Players
%
% This script contains the code of the Sequential Investment Game for two
% players, which is part of the GESS course "Modelling and Simulating Social
% Systems with MATLAB".
%
% Authors: Fabian Keller, Sebastian Klotz, Simon Zimmermann
% Date: 08.12.2014
% Version 3

clear all
clc
close all

% Variable definition

D = 100;                      % repeats of one game
%N = 100;                    % number of repeats
N = 1000;
g = 100;                     % number of games per repeat
n = 10;                     % number of rounds per game

m_start = 100;              % starting money
p = 60;                     % probability of winning in %
c = 0;                      % number of games since last strategy change
c_max = 0;                  % max round of strategy kept
winner = 0;                 % winner of last game (1 or 2)
median = 0;                 % median
strategy = 0;               % which strategy the loser chooses (row of matrix)
row = 1;                    % row of strategy_matrix
noise = N/40;               % noise factor
noise_1 = 0;                % noise factor of player 1
noise_2 = 0;                % noise factor of player 2

s_min = 2;
s_max = 80;

win_1 = 0;                  % player 1 wins total
win_2 = 0;                  % player 2 wins total
row_1 = 0;                  % Strategy-N? P1
row_2 = 0;

% Matrix of mutations
strategy_matrix = [3 2 1 0 0 0 0 0 0 0;
                   -3 -2 -1 0 0 0 0 0 0 0;
                   0 0 0 0 0 0 0 1 2 3;
                   0 0 0 0 0 0 0 -1 -2 -3];
               
strategy_matrix = strategy_matrix/5;

strategy_kelly = [20 20 20 20 20 20 20 20 20 20];

strategy_matrix_1 = zeros(N,n);
strategy_matrix_2 = zeros(N,n);

strategy_1 = strategy_kelly;
strategy_2 = strategy_kelly;

strategy_matrix_w = zeros(N,n);

% VARIABLES DATASET

top_10_number = zeros(10,1);
top_10_win_strategies = zeros(10,10);
top_10 = zeros(10,1);

% ----------
%    GAME   
% ----------

for d = 1:1:D

    % starting strategies
    
     strategy_1 = strategy_kelly;
     strategy_2 = strategy_kelly;
     
    i = 1;
    
    while(i <= N)
        % repeat

        w_1 = 0;  % wins player 1 per repeat (NOT total)
        w_2 = 0;

        % Noise
        noise = noise - 1;

        % For player 1
        if randi(N) <= noise
            strategy_1 = strategy_kelly;

            noise_1 = noise_1 + 1;

            for j = 1:1:size(strategy_matrix,1)
                strategy_1 = strategy_1 + randi(3)*strategy_matrix(j,:);
            end

        end

        % For player 2

        if randi(N) <= noise
            strategy_2 = strategy_kelly;

            noise_2 = noise_2 + 1;

            for j = 1:1:size(strategy_matrix,1)
                strategy_2 = strategy_2 + randi(3)*strategy_matrix(j,:);
            end

        end

        for j = 1:1:g
            %game

            m_1 = m_start;
            m_2 = m_start;

            for k = 1:1:n
                % round

                % player 1
                if randi(100) <= p
                    m_1 = m_1 + m_1*strategy_1(k)/100;
                else
                    m_1 = m_1 - m_1*strategy_1(k)/100;
                end

                % player 2
                if randi(100) <= p
                    m_2 = m_2 + m_2*strategy_2(k)/100;
                else
                    m_2 = m_2 - m_2*strategy_2(k)/100;
                end

            end

            % wins

            if m_1 > m_2
                w_1 = w_1 + 1;
            elseif m_2 > m_1
                w_2 = w_2 + 1;
            end

        end

        % strategy change

        if w_1 > w_2 
            % PLAYER 1 WINS

            % player 1 sticks to strategy
            win_1 = win_1 + 1;
            strategy_matrix_w(i,:) = strategy_1;

            if winner == 1
                % AGAIN

                c = c + 1; 
                median_old = median;
                median = (median_old*(c-1) + w_1 - w_2)/c;

            else
                % FIRST TIME

                if c > c_max
                    c_max = c;
                end

                c = 1;
                winner = 1;
                median_old = g;
                median = w_1 - w_2;

            end

            % Player 2 mutatates

            if median_old <= median
                % improved strategy -> continue

                if strategy_2(1) >= s_min && strategy_2(n) >= s_min && strategy_2(1) <= s_max && strategy_2(n) <= s_max
                    strategy_2 = strategy_2 + strategy;
                end

            else
                % new strategy

                if c > 1 && strategy_2(1) >= s_min && strategy_2(n) >= s_min && strategy_2(1) <= s_max && strategy_2(n) <= s_max
                   % revert changes 
                   strategy_2 = strategy_2 - strategy;
                end

                if row_2 <= 2
                    row_2 = randi([3,4]); % tail
                else
                    row_2 = randi([1,2]); % head
                end

                strategy = strategy_matrix(row_2,:);

                if strategy_2(1) >= s_min && strategy_2(n) >= s_min && strategy_2(1) <= s_max && strategy_2(n) <= s_max
                    strategy_2 = strategy_2 + strategy;
                end

            end

        elseif w_2 > w_1
           % PLAYER 2 WINS

            % player 2 sticks to strategy
            win_2 = win_2 + 1;
            strategy_matrix_w(i,:) = strategy_1;

            if winner == 2
                % AGAIN

                c = c + 1; 
                median_old = median;
                median = (median_old*(c-1) + w_2 - w_1)/c;

            else
                % FIRST TIME

                if c > c_max
                    c_max = c;
                end

                c = 1;
                winner = 2;
                median_old = g;
                median = w_2 - w_1;

            end

            % Player 1 mutatates

            if median_old <= median
                % improved strategy -> continue

                if strategy_1(1) >= s_min && strategy_1(n) >= s_min && strategy_1(1) <= s_max && strategy_1(n) <= s_max
                    strategy_1 = strategy_1 + strategy;
                end

            else
                % new strategy

                if c > 1 && strategy_1(1) >= s_min && strategy_1(n) >= s_min && strategy_1(1) <= s_max && strategy_1(n) <= s_max
                   % revert changes 
                   strategy_1 = strategy_1 - strategy;
                end

                if row_1 <= 2
                    row_1 = randi([3,4]); % tail
                else
                    row_1 = randi([1,2]); % head
                end

                strategy = strategy_matrix(row_1,:);

                if strategy_1(1) >= s_min && strategy_1(n) >= s_min && strategy_1(1) <= s_max && strategy_1(n) <= s_max
                    strategy_1 = strategy_1 + strategy;
                end

            end

        end

        strategy_matrix_1(i,:) = strategy_1;    % log
        strategy_matrix_2(i,:) = strategy_2;    % log

        if w_1 == w_2
            % draw

            % "mark" row
            strategy_matrix_w(i,:) = 0;

            % repeat loop
            i = i-1;
        end

        i = i + 1; % index variable

    end
    
    B = sortrows(strategy_matrix_w);
    S = [1;any(diff(B),2)];
    [L,S] = regexp(sprintf('%i',S'),'1(0)+');
    repeated_rows = B(S,:);             % Repeated Rows.
    repeat_count = (S-L+1)';            % How often each repeated row appears.

    [sort_val_1,sort_ind_1] = sort(repeat_count, 'descend');

    length(sort_val_1)
    
    if length(sort_val_1) >= 10
        top_10 = sort_val_1(1:10);
        top_10_number = top_10_number + top_10;

        top_10_strategies = repeated_rows(sort_ind_1(1:10),:);
        top_10_win_strategies = top_10_win_strategies + top_10_strategies;
    end

end
    
top_10_number = top_10_number / D
top_10_win_strategies = top_10_win_strategies/D

% Plots
figure(1)
subplot(1,2,1)
imagesc(top_10_win_strategies)
title('Plot of top strategies for D');
xlabel('Number of bets');
ylabel('Strategies');
colorbar
subplot(1,2,2)
plot(top_10_number, '.')
title('top strategy distribution for D');
xlabel('Number of type of strategy used');
ylabel('Number of strategy used');





        
     