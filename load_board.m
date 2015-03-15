function [err_code, varargout] = load_board(hBtnGrp)
%LOAD_BOARD takes the user input and either loads a custom board or the
%generic one. It returns an error code to show if loaded properly. This
%allows us to give the user choices again. The size array and action array
%are used once the game starts to determine token position and gameplay.
%   Takes an input from the user on the board choice. The tags dictate
%   custom board or generic board. A switch is called to choose the
%   subfunction for board loading.
%   EX:
%   [err_code, size_arr, action_arr] = load_board(1);

% Switch of two cases acts as a hash map which is slower than if else,
% under five options, but it is better Matlab style.

% Look for the current event from board choice callback function
% Grabs from gui handle.
switch get(get(hBtnGrp,'SelectedObject'),'Tag')
    case 'ub'
        [err_code, varargout{1}, varargout{2}] = own_board();
    case 'gb'
        [err_code, varargout{1}, varargout{2}] = generic_board(10,10);
    otherwise
        err_code = -1;
end

if (err_code == -1)
    fprintf('Board did not load properly.\n');
end

end


function [err_code, varargout] = own_board()
%OWN_BOARD brings in the user created board for use in the game.
%   Opens the file containing the board specs, reads them into a size array
%   and action array, then uses the size array to determine the positions
%   of the shapes.
%   EX:
%       own_board()

% TBD: Ask for the directory, then the file, then open
test_folder_str = 'C:\Users\Nick\Desktop\su classes\ecegre\ecegre 1000\final_proj\folder\';
fid = fopen([test_folder_str 'board_1.txt']);
if (fid == -1)
    fprintf('The file could not open properly.');
    err_code = -1;
    return;
end

% Read in text file for board pieces
rec_lin = textscan(fid', '%f%f%f%f%f', 'CollectOutput', 1);
% Close file
fclose(fid);

% Brackets are for readability
size_arr = rec_lin{1}(:, [1:4]);
[sizex, sizey] = size(size_arr);
act_arr = rec_lin{1}(:,5);

% Layout board for further placement of tiles
board_layout();

% Choose color scheme
color_mat = [0.2 0.2 0.2];

% Use rectangles
for (index = 1:sizex)
rectangle('Position',size_arr(index,:), 'FaceColor', color_mat,...
        'EdgeColor', [0.9 0.1 0.1], 'LineWidth', 2);
end

% Assign outputs now that everything is set up
err_code = 0;
varargout{1} = size_arr;
varargout{2} = act_arr;

end

function [err_code, size_arr, act_arr] = generic_board(x_size, y_size)
%GENERIC_BOARD brings up a generic board for use in the game.
%   An x and y size are passed in. Board spaces are then layed out in a
%   closed square.
%   EX:
%       generic_board(10,10)

size(size_arr);
act_arr = rec_lin(:,5);

% Layout board for further placement of tiles
fig = board_layout();
final_pos = 1 + (10* (x_size-1));

% Iterate through columns
for (y_rectangle = 1:y_size)
    % Calc the column space
    y_pos = 1 + (10* (y_rectangle-1));
    % Place a full row of x_size if satisfied by mod y_size.
    if (~mod(y_pos,y_size))
        % Iterate through row positions to place rectangles
        for (x_rectangle = 1:x_size)
            % Calc the row space
            x_pos = 1 + (10* (x_rectangle-1));
            % Place a predefined rectangle at the given pos
            gen_rect(x_pos, y_pos);
        end
    else
        % Place a full column otherwise
        gen_rect(1, y_pos);
        gen_rect(final_pos, y_pos);
    end
end

err_code = 1;

end


function gen_rect(x_pos, y_pos)
%GEN_RECT Creates a rectangle of the generic board specs
%   Defines a rectangle in the required space according to the position
%   passed it and all other specs are predefined since this is used
%   frequently.
%   EX:
%   gen_rect(10, 10);

% Decide color palet
color_mat = [0.5 0.9 0.5];
    
% Rectangle of size 10x10 at passed position and before the text
rectangle('Position', [x_pos y_pos 10 10], 'FaceColor', color_mat,...
    'EdgeColor', [0.9 0.1 0.1], 'LineWidth', 2);

end
