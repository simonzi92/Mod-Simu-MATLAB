% SKRIPTMASTER: Sequential Investment Game for two Players
%
% This script contains the code of the Sequential Investment Game for two
% players, which is part of the GESS course "Modelling and Simulating Social
% Systems with MATLAB".
%
% Authors: Fabian Keller, Sebastian Klotz, Simon Zimmermann
% Date: 08.12.2014
% Version 4

close all
clear all
clc

%--------------------------------------%
% variables
%--------------------------------------%

g=0;                    %number of games
r=1000;                 %number of rounds per gae
t=10;                   %number of turns per romund
p=60;                   %probability to win [%]
k=100;                  %amount of currency each player starts with
lowest_bet=20;          %in [%]
step_size=2;            %in [%]
top_bet=26;             %in [%]
log_nr=0;               %log counter
strategy_matrix_w = zeros(1,12); % log of winning strategies
c = 0;                  % counter for strategy_matrix_w

%win=zeros(r,2);        %matrix with wins
win1=0;
win2=0;
strat=zeros(1,10);      %bets of player 2 for every turn (each turn = column)
%start_value=20;        %value for the bets of player two to start from

%--------------------------------------%
%fill strat with start values
%--------------------------------------%

for i=1:1:10
    strat(1,i)=lowest_bet;
end

%--------------------------------------%
%play the game
%--------------------------------------%
f=0;

while f==0
    g=g+1
    strat_log=zeros(g,11); %log of the strategy matrix that won against kelly and in which game
    
    %generate all possbile strategies
    if (strat(1,1)==top_bet)&&(strat(1,2)==top_bet)&&(strat(1,3)==top_bet)&&(strat(1,4)==top_bet)&&(strat(1,5)==top_bet)&&(strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
        f=1;
    else
        if (strat(1,2)==top_bet)&&(strat(1,3)==top_bet)&&(strat(1,4)==top_bet)&&(strat(1,5)==top_bet)&&(strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
            strat(1,1)=strat(1,1)+step_size;
            strat(1,2)=lowest_bet;
            strat(1,3)=lowest_bet;
            strat(1,4)=lowest_bet;
            strat(1,5)=lowest_bet;
            strat(1,6)=lowest_bet;
            strat(1,7)=lowest_bet;
            strat(1,8)=lowest_bet;
            strat(1,9)=lowest_bet;
            strat(1,10)=lowest_bet;
        else
            if (strat(1,3)==top_bet)&&(strat(1,4)==top_bet)&&(strat(1,5)==top_bet)&&(strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                strat(1,2)=strat(1,2)+step_size;
                strat(1,3)=lowest_bet;
                strat(1,4)=lowest_bet;
                strat(1,5)=lowest_bet;
                strat(1,6)=lowest_bet;
                strat(1,7)=lowest_bet;
                strat(1,8)=lowest_bet;
                strat(1,9)=lowest_bet;
                strat(1,10)=lowest_bet;
            else
                if (strat(1,4)==top_bet)&&(strat(1,5)==top_bet)&&(strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                    strat(1,3)=strat(1,3)+step_size;
                    strat(1,4)=lowest_bet;
                    strat(1,5)=lowest_bet;
                    strat(1,6)=lowest_bet;
                    strat(1,7)=lowest_bet;
                    strat(1,8)=lowest_bet;
                    strat(1,9)=lowest_bet;
                    strat(1,10)=lowest_bet;
                else
                    if (strat(1,5)==top_bet)&&(strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                        strat(1,4)=strat(1,4)+step_size;
                        strat(1,5)=lowest_bet;
                        strat(1,6)=lowest_bet;
                        strat(1,7)=lowest_bet;
                        strat(1,8)=lowest_bet;
                        strat(1,9)=lowest_bet;
                        strat(1,10)=lowest_bet;
                    else
                        if (strat(1,6)==top_bet)&&(strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                            strat(1,5)=strat(1,5)+step_size;
                            strat(1,6)=lowest_bet;
                            strat(1,7)=lowest_bet;
                            strat(1,8)=lowest_bet;
                            strat(1,9)=lowest_bet;
                            strat(1,10)=lowest_bet;
                        else
                            if (strat(1,7)==top_bet)&&(strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                                strat(1,6)=strat(1,6)+step_size;
                                strat(1,7)=lowest_bet;
                                strat(1,8)=lowest_bet;
                                strat(1,9)=lowest_bet;
                                strat(1,10)=lowest_bet;
                            else
                                if (strat(1,8)==top_bet)&&(strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                                    strat(1,7)=strat(1,7)+step_size;
                                    strat(1,8)=lowest_bet;
                                    strat(1,9)=lowest_bet;
                                    strat(1,10)=lowest_bet;
                                else
                                    
                                    if (strat(1,9)==top_bet)&&(strat(1,10)==top_bet)
                                        strat(1,8)=strat(1,8)+step_size;
                                        strat(1,9)=lowest_bet;
                                        strat(1,10)=lowest_bet;
                                        
                                    else
                                        if strat(1,10)==top_bet
                                            strat(1,9)=strat(1,9)+step_size;
                                            strat(1,10)=lowest_bet;
                                        else
                                            strat(1,10)=strat(1,10)+step_size;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    for i=1:1:r
       k1=k;
       k2=k;
       for j=1:1:t

           %player 1
           rand1=randi(100,1,1);
           if rand1 <= p
               k1=k1+(0.2*k1);
           else
               k1=k1-(0.2*k1);
           end

           %player 2
           rand2=randi(100,1,1);
           if rand2 <= p
               k2=k2+((strat(1,j)*k2)/100);
           else
               k2=k2-((strat(1,j)*k2)/100);
           end



       end

       if k1 > k2           %player 1 wins the round
%             win(i,1)=1;
%             win(i,2)=0;
              win1=win1+1;
       else                 %player 2 wins the round
%             win(i,2)=1;
%             win(i,1)=0;
              win2=win2+1;
       end

    end   
    
%     win1=sum(win(:,1));
%     win2=sum(win(:,2));
    
    
    diff(1,g)=win1-win2;
    
%     if win2 <= win1
%         log_nr=log_nr+1;
%         strat_log(log_nr,11)=g;

    win(1,g)=win1;
    win(2,g)=win2;
    
    if win2 > win1
        c = c + 1;
        for j = 1:1:10
            strategy_matrix_w(c,j) = strat(1,j);
            strategy_matrix_w(c,11) = win2;
            strategy_matrix_w(c,12) = g;
        end
    end
    
    win1=0;
    win2=0;
    
    clc
    
end
    
figure(1)
plot(diff)
title('Difference between wins')

figure(2)
plot(win(1,:),'b')
hold on
plot(win(2,:),'r')
legend('wins player 1','wins player 2')
title('Wins')
xlabel('games')
ylabel('number of wins')

% END OF SIG_V4


