function check_leader(player_info, leader_is_text, player_size, player_turn)
%CHECK_LEADER check for the current leader.
%   The leader is the person furthest ahead but who has not completed the
%   game. This is done by checking the position and game done flag in the
%   info of the person.

pos_max = 0;
for(R = 1:player_size)
    % Check for max position and not done with game
    if((player_info(R).player_pos > pos_max) && ~player_info(R).game_done)
        pos_max = player_info(R).player_pos;
        % Set the leader
        leader = R;
    end
end
% Update the string
set(leader_is_text, 'Visible','on', 'String', ['Player ' num2str(leader) ' is leading.']);

end

