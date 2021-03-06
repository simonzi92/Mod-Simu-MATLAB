% SKRIPTMASTER: Sequential Investment Game for two Players
%
% This script contains the code of the Sequential Investment Game for two
% players, which is part of the GESS course "Modelling and Simulating Social
% Systems with MATLAB".
%
% Authors: Fabian Keller, Sebastian Klotz, Simon Zimmermann
% Date: 11.11.2014
% Version 1

clear all
close all
clc

% Variable definition

N = 1000;       % number of repeats
n = 10;         % number of games per repeat
p = 60;         % winning probability (in %, 0 - 100)
m_start = 100;  % start amount of money

% Players

bet_1 = zeros(N,1);         % bet player 1 (in %)
bet_1(1,1) = 5;             % starting bet player 1 (in %)
bet_2 = zeros(N,1);         % bet player 2 (in %)
bet_2(1,1) = 25;            % starting bet player 2 (in %)
score_1 = zeros(N,n+1);     % scores of player 1 in one repeat
score_2 = zeros(N,n+1);     % scores of player 2 in one repeat
history_1 = zeros(N,n);     % win (=1) / lose (=0) history of player 1 in one game (random)
history_2 = zeros(N,n);     % win (=1) / lose (=0) history of player 2 in one game (random)    
win_1 = zeros(N,1);         % win (=1) / lose (=0) history of player 1 in one repeat   
win_2 = zeros(N,1);         % win (=1) / lose (=0) history of player 2 in one repeat

%REF = reference_matrix(10,60);

load('ref.mat');

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
    
% Determine win or lose
    
    if score_1(i,11) >= score_2(i,11)
        win_1(i) = 1;
    elseif score_2(i,11) >= score_1(i,11)
        win_2(i) = 1;
    end
            
% Fictitious Play -> adapt strategy
    if i < N
        [bet_1(i+1,1),bet_2(i+1,1)] = fictitious_play(REF,bet_1(i,1),bet_2(i,1));
    end

end

% Sum of wins

sum_1 = sum(win_1)
sum_2 = sum(win_2)

if sum_1 > sum_2
    disp('Player 1 wins the game!')
elseif sum_1 < sum_2
    disp('Player 2 wins the game!')
else disp('Draw!')
end

%Plot of scores
figure(1);
plot(1:N,score_1(:,11),'b-x')
hold on
plot(1:N,score_2(:,11),'r-x')
xlim([1 N]);
title('Plot of scores');
xlabel('Number of game');
ylabel('Scores');
legend('Player 1','Player 2');

%Plot of bets
figure(2);
plot(1:N,bet_1(:,1),'.b')
hold on
plot(1:N,bet_2(:,1),'.r')
xlim([1 N+1]);
title('Plot of bets');
xlabel('Number of game');
ylabel('bets');
legend('Player 1','Player 2');

% END OF SIG_V1
        