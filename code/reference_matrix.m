% This function generates the reference table for both players for SIG_V1

function [REF] = reference_matrix(n, p)
    
    n_table = 10000; % Number of reference plays
    REF = zeros(101,101); % Reference Matrix

    for i = 1:1:101
        for j = 1:1:101           

            % Game
            for k = 1:1:n_table

                money_1 = 100;
                money_2 = 100;

                for l = 1:1:n
                    % game for player 1
                    rand = randi(100);
                    if rand <= p           % win
                        money_1 = money_1 + (i-1)/100*money_1;
                    else                        % lose
                        money_1 = money_1 - (i-1)/100*money_1; 
                    end

                    % game for player 2
                    rand = randi(100);
                    if rand <= p           % win
                        money_2 = money_2 + (j-1)/100*money_2;
                    else                        % lose
                        money_2 = money_2 - (j-1)/100*money_2; 
                    end
                end

                % write REF

                if money_1 > money_2
                    REF(i,j) = REF(i,j) + 1;
                elseif money_2 > money_1
                    REF(i,j) = REF(i,j) - 1;                
                end

            end

        end
    end
    
    figure
    imagesc(REF)
    
end