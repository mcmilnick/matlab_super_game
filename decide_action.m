function [err_code, player_info] = decide_action(player_info,...
    cur_action, size_len, player_turn)
%DECIDE_ACTION performs an action on the player whos turn it is.
%   The action is chosen by cur_action which is put through a switch case
%   to perform the given operation(s) on the player struct. If the player
%   is put before spot 0 they are brought back to 0 (begining).

err_code = 0;
switch cur_action
    case 1
        player_info(player_turn).player_pos = 2;
    case 2
        player_info(player_turn).player_pos = 4;
    case 3
        player_info(player_turn).player_pos = size_len;
    case 4
        player_info(player_turn).player_pos = -2;
    case 5
        player_info(player_turn).player_pos = -4;
    case 6
        player_info(player_turn).player_pos = 0;
    case 7
        player_info(player_turn).skip_turn = 1;
    case 8
        player_info(player_turn).roll_again = 1;
    case 9
        player_info(player_turn).player_pos = -3;
        player_info(player_turn).skip_turn = 1;
    case 10
        player_info(player_turn).player_pos = 3;
        player_info(player_turn).roll_again = 1;
    otherwise
        err_code = -1;
end

% Check if we have gone before to a negative space
if(player_info(player_turn).player_pos < 0)
    player_info(player_turn).player_pos = 0;
end

end
