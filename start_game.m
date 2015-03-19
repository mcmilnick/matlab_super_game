function [player_info] = start_game(player_names, size_arr, act_arr,...
    die_rolls, fig_handle, leader_text, leader_is_text, place_1,...
    place_2, place_3, place_4, reset_but)
%START_GAME is the start of the action phase of the game.
%   The passed in arrays all allow us to in find the order of people, the
%   corresponding die rolls, the space we are on, and the action at that
%   space. The setup of the program thus far ensures that it is a simple
%   task of accessing arrays in the correct order, Also, I truly dislike
%   all the commenting, as to much comment makes code look ugly and clean
%   code speaks for itself. I only say this because the loops here look
%   really large, but it is really just all comment for grading purposes.
%   Actions ar limited to one per turn. This is a personal choice to avoid
%   cascading actions as I am infering this was not the intent of the
%   project. I am assuming strange input boards where it would be one turn
%   and over.
%   EX:
%       start_game(player_names, size_arr, act_arr, die_rolls);

size_len = length(size_arr);
player_size = length(player_names);
%Handles for player tokens
tok_handle = cell(player_size,1);
text_handle = cell(player_size,1);
%Local variable for deciding who won.
placement_num = 1;
if(~player_size)
    return;
end

% Save player info as struct if it isn't getting passed. Now it will not
% clog memory and will prove useful in bunching data.
for (player_structs = 1:player_size)
    player_info((player_size-player_structs)+1).name = player_names{player_structs};
    % Start players at position 0 without a location.
    player_info((player_size-player_structs)+1).player_pos = 1;
    % Store if the player is to take their turn (used for skip turns)
    player_info((player_size-player_structs)+1).skip_turn = 0;
    player_info((player_size-player_structs)+1).roll_again = 1;
    player_info((player_size-player_structs)+1).game_done = 0;
    player_info((player_size-player_structs)+1).actions = [];
end

% The leader will now be displayed
set(leader_text, 'Visible','on');

turn_counter = 1;
continue_actions = 1;
% Keep game going until all players are done
while(sum([player_info.game_done]) ~= player_size)
    %Cycle through players
    for(player_turn = 1:player_size)
        % Roll again is set at the start and after the user goes. It is
        % reset if they get a roll again.
        if(~player_info(player_turn).game_done)
            % Always check for reset button
            if(~isempty(reset_but.UserData))
                return;
            end
            if (player_info(player_turn).skip_turn)
                % Reset skip turn
                player_info(player_turn).skip_turn = 0;
            else
                % Allow first roll
                player_info(player_turn).roll_again = 1;
                while(continue_actions)
                    if (player_info(player_turn).roll_again == 1)
                        % We only roll on start or on a neutral space
                        [cur_roll] = roll_die(die_rolls, player_turn,turn_counter);
                        player_info(player_turn).player_pos = player_info(player_turn).player_pos + cur_roll;
                    end
                    % Must be reset by the space or start of next turn.
                    player_info(player_turn).roll_again = 0;
                    %Check the action at the space. If past finish, set action
                    %to go to fin so check is not duplicated.
                    if(player_info(player_turn).player_pos >= length(act_arr))
                        cur_action = 3;
                        player_info(player_turn).player_loc = size_arr(end);
                        set(leader_text, 'Visible','on', 'String', ['Player ' num2str(player_turn) ' is done.']);
                    else
                        cur_action = act_arr(player_info(player_turn).player_pos);
                        set(leader_text, 'Visible','on', 'String', ['Player ' num2str(player_turn) ' hit a ' num2str(cur_action)]);
                        % Find the new coordinates specified by how many squares in you are.
                        player_info(player_turn).player_loc = size_arr(player_info(player_turn).player_pos);
                    end
                    % Wait for realistic feels
                    
                    [tok_handle{player_turn}, text_handle{player_turn}] =...
                        update_token(size_arr, player_info, fig_handle,...
                        player_turn, tok_handle, text_handle);
                    uiwait(gcf,1);
                    
                    % Store all actions for a player
                    player_info(player_turn).actions(turn_counter) = cur_action;
                    % Pass in the action and update the player struct. The same struct is passed
                    % in and out. In Matlab there is no passing by reference unless a handle.
                    % Normally bad style, but in recent versions is an optimization where
                    % passing the same variable in and out does not create a copy and acts
                    % like passing by reference(fast, cool little secret).
                    [err_code, player_info] = decide_action(player_info, cur_action, size_len, player_turn);
                    if(err_code == -1)
                        fprintf('Your board contains an illegal action.\n');
                    end
                    
                    [tok_handle{player_turn}, text_handle{player_turn}] =...
                        update_token(size_arr, player_info, fig_handle,...
                        player_turn, tok_handle, text_handle);
                    uiwait(gcf,1);
                    % Check if player has reached a spot of no actions(or unknown spot).
                    [continue_actions, player_info, placement_num] = ...
                        continue_check(player_info, act_arr, player_turn,...
                        err_code, place_1, place_2, place_3, place_4,...
                        turn_counter, placement_num, size_len);
                end
                % We may move on since they did not land on a special spot
                continue_actions = 1;           
            end
        end
    end
    % Update turn counter
    turn_counter = turn_counter + 1;
    % After each player update the leader
    check_leader(player_info, leader_is_text, player_size, player_turn);
end

end
