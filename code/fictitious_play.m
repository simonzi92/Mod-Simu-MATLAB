% This file contains the "fictitous play"-function for SIG_V1

function[bet_1, bet_2] = fictitious_play(REF, bet_1, bet_2)
      
% Range

    range = 2;

% Player 1:
    
    max_vector_1 = 0;
    max_vector_2 = 0;
    
    max_value_1 = max(REF(2:60, bet_2));
    
    for m = 2:1:60
        if REF(m, bet_2) >= (max_value_1-range)
            if max_vector_1 == 0
                max_vector_1 = m;
            else
                max_vector_1 = [max_vector_1; m];
            end
        end
    end
    
    % Player 2:

    max_value_2 = min(REF(bet_1, 2:60));
    
    for m = 2:1:60
        if REF(bet_1, m) <= (max_value_2+range)
            if max_vector_2 == 0
                max_vector_2 = m;
            else
                max_vector_2 = [max_vector_2; m];
            end
        end
    end
    
    bet_1 = max_vector_1( randi( length(max_vector_1) ),1);
    bet_2 = max_vector_2( randi( length(max_vector_2) ) ,1);
    
    if length(max_vector_1) > 1
        max_vector_1;
    elseif length(max_vector_2) > 1
        max_vector_2;
    end
    
end

