function [err_code, fig_handle] = import_token(pic_file, player_names, num_players)

err_code = -1;

% Search picture directory for all jpg files. Store them in a struct.
if (~isempty(pic_file.UserData))
    cd(pic_file.UserData);
end
pic_players = dir('*.jpg');
% Get the number of pictures
pic_len = length(pic_players);
    
% Create a figure handle matrix
fig_handle = cell(num_players,1);

% Cycle through players
for(play_count = 1:num_players)
    % Get each picture to check against each player
    for (pic_count = 1:pic_len)
        player_new = pic_players(pic_count).name;
        % Compare them to find a match
        str_same = strcmpi(player_new(1:(end-4)),player_names(play_count));
        % If they match
        if(str_same)
            fig_handle{play_count} = imread(player_new);
        end
    end
    % All figure are set. If figure is not set for a given player, they get
    % the default token. This will be denoted by a circle when the board is
    % updated.
end

err_code = 0;
end

function [fig_handle] = set_token(in_name)

new_image = imread(in_name);

fig_handle = new_image;

end