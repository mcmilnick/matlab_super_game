function [continue_actions, player_info, placement_num] = ...
    continue_check(player_info, act_arr, player_turn, err_code, place_1,...
    place_2, place_3, place_4, turn_counter, placement_num, size_len)
%CONTINUE_CHECK checks if you have landed on another action space after
%moving due to an action space.
% This checks if we are currently on a no action, the start, skip turn, or
% the end. In addition, if the error returned from the action choice
% function is -1, then the current action is undefined. All of these cases
% mean do not move again.
if(player_info(player_turn).player_pos >= size_len)
    % Reached the end or gone past.
    continue_actions = 0;
    player_info(player_turn).game_done = 1;
    % Show their placement
    update_placement(placement_num, player_turn, place_1, place_2,...
        place_3, place_4, turn_counter);
    placement_num = placement_num + 1;
end

if (act_arr(player_info(player_turn).player_pos) == -1)
    continue_actions = 0;
elseif(act_arr(player_info(player_turn).player_pos) == 0)
    continue_actions = 0;
elseif(act_arr(player_info(player_turn).player_pos) == 7)
    % Notice we continue on 7 but not 9 because moving back three may put
    % you on another spot. You will still lose your turn next time on 9.
    continue_actions = 0;
elseif(act_arr(player_info(player_turn).player_pos) == 100)
    continue_actions = 0;
elseif(err_code == -1)
    continue_actions = 0;
else
    continue_actions = 1;
end

end

function update_placement(placement_num, player_turn, place_1, place_2,...
    place_3, place_4, turn_counter)
%UPDATE_PLACEMENT switches based on the number of people who have finished
%before you. This counts up and displays the player number who finished in
%the given place and in how many turns.

switch placement_num
    case 1
        set(place_1, 'Visible','on', 'String',['Player ' num2str(player_turn) ' achieved 1st in ' num2str(turn_counter) ' turns.']);
    case 2
        set(place_2, 'Visible','on', 'String',['Player ' num2str(player_turn) ' achieved 2nd in ' num2str(turn_counter) ' turns.']);
    case 3
        set(place_3, 'Visible','on', 'String',['Player ' num2str(player_turn) ' achieved 3rd in ' num2str(turn_counter) ' turns.']);
    case 4
        set(place_4, 'Visible','on', 'String',['Player ' num2str(player_turn) ' achieved 4th in ' num2str(turn_counter) ' turns.']);
    otherwise
        fprintf('This player does not exist.\n');
        
end

end
