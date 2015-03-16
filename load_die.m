function [err_code, varargout] = load_die(die_radio, player_num)
%LOAD_DIE loads in the die rolls from a text file or decides to use random
%rolls.
%   The gui handle is used to decide if the die are random or from a file.
%   Both return a cell array. If there are empty cells is means use the
%   generic die for that user. This can also be present in the own die
%   option if there are more players than die columns.
%   Cell array size depends on the number of players passed
%   in. This array is then passed back as varargout because if we don't 
%   need it (like in getting an error), then we avoid passing back a
%   worthless variable.

% Default die rolls for generic die
% This empty cell matrix will signify all players get generic die.
varargout{1} = cell(player_num,1);

% Switch case for finding the die choice. Grabs from gui handle.
switch get(get(die_radio,'SelectedObject'),'Tag')
    case 'ud'
        [err_code, varargout{1}] = own_die(player_num);
    case 'gd'
        % Taken care of by default
    otherwise
        err_code = -1;
end

% We have made it successfully
err_code = 0;

end


function [err_code, player_rolls] = own_die(player_num)
%OWN_DIE loads in the die rolls from a text document. Each column dictates
%the rolls for each player.

% Set the error code for if we hit an error midway
err_code = -1;

% Open file
fid = fopen('C:\Users\Nick\Desktop\su classes\ecegre\ecegre 1000\final_proj\folder\dice_roll_1.txt');
if (fid == -1)
    fprintf('The die file could not open properly.\n');
    return;
end
die_rolls = textscan(fid, '%s', 'delimiter', '0');

fclose(fid);

% Create a cell array of the die rolls. The size is the number of players.
% If the player does not fill all active players, the empty cell will be
% dealt with later by random die.
player_rolls = cell(player_num,1);

% The number of players is capped at the active player count
[x_size, y_size] = size(die_rolls{1});
if (x_size > player_num)
    fprintf('There are only %d people playing.\n', player_num);
    fprintf('Some rolls will not be used.\n');
end

% The number of players can be variable. If there are less rolls here than
% players specified on the main screen, then the extras will get random
% die as specified by the preallocated cell.
if (player_num >= x_size)
    count = x_size;
else
    count = player_num;
end

for (R = 1:count)
    player_rolls{R} = str2num(die_rolls{1}{R});
end

% We made it successfully
err_code = 0;

end

