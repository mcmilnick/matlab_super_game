function [player_arr, length_play] = get_user_names(name_1, name_2, name_3, name_4)

player_arr = cell(4,1);
player_arr{1} = get(name_1, 'String');
player_arr{2} = get(name_2, 'String');
player_arr{3} = get(name_3, 'String');
player_arr{4} = get(name_4, 'String');

% The alternative is an if else for each string to compare and store.
% Read names and get rid of players without an entered name.
length_play = 4;
R = 1;
while ((R <= length_play) && ~isempty(player_arr))
    % If they are the same that player is not playing
    if (strcmp(player_arr{R},'Player'))
        player_arr(R) = [];
        % number of players
        length_play = length_play - 1;
    else
        R = R + 1;
    end
end

end
