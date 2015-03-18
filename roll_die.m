function [cur_roll] = roll_die(die_rolls, player_turn, turn_counter)
%ROLL_DIE rolls a die on each turn.
%   If a predetermined die array is being used we access that based on the
%   player number deciding the row and the turn count deciding the column
%   index. If the column runs out it switches to the generic random die. If
%   generic is chosen from the start it also gets this die.

die_arr = die_rolls{player_turn};
% Check if the player doesn't have an assigned die which will have an
% empty cell, or if the assigned array is past its end (rolls all used).
if (length(die_arr) < turn_counter)
    % Roll a generic die
    cur_roll = randi([1 6]);
else
    % Use predetermined die roll
    cur_roll = die_arr(turn_counter);
end

end