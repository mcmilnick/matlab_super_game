function [err_code, varargout] = load_board(board_radio, board_file_name)
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
switch get(get(board_radio,'SelectedObject'),'Tag')
    case 'ub'
        [err_code, varargout{1}, varargout{2}] = own_board(board_file_name);
    case 'gb'
        [err_code, varargout{1}, varargout{2}] = generic_board(10,10);
    otherwise
        err_code = -1;
end

end


function [err_code, varargout] = own_board(board_file_name)
%OWN_BOARD brings in the user created board for use in the game.
%   Opens the file containing the board specs which was selected in the
%   gui, then reads them into a size array and action array, uses the size
%   array to determine the positions of the shapes. They are placed on the
%   main gui screen.
%   EX:
%       own_board()

err_code = -1;

fid = fopen(board_file_name);
if (fid == -1)
    fprintf('The board file could not open properly.\n');
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
string_arr = {'Jump 2'; 'Jump 4'; 'Go to Finish'; 'Back 2'; 'Back 4';...
    'Back to Start'; 'Turn(-1)'; 'Roll';...
    'Turn(-1) Back 3'; 'Roll Jump 3'};

% Choose color scheme
color_mat = [0.2 0.2 0.2];
% Updated screen size
scrsz = get(0,'ScreenSize');
% Use rectangles
for (index = 1:sizex)
    rectangle('Position',size_arr(index,:), 'FaceColor', color_mat,...
        'EdgeColor', [0.9 0.1 0.1], 'LineWidth', 2);
    
    % Place text
    x_pos = (size_arr(index,1) + scrsz(4)/420);
    y_pos = (size_arr(index,2) + scrsz(3)/200);
    if (act_arr(index) == 0)
        text(x_pos, y_pos, 'Start', 'color', 'y',  'FontName', 'Verdana');
    elseif (act_arr(index) == 100)
        text(x_pos, y_pos, 'Finish', 'color', 'y', 'FontName', 'Verdana');
    else
        [one_str, two_str] = strtok(string_arr(abs(act_arr(index))),' ');
        text(x_pos, y_pos, char([one_str;two_str]), 'color',...
            'y', 'FontName', 'Verdana');
    end
end

% Assign outputs now that everything is set up
err_code = 0;
varargout{1} = size_arr;
varargout{2} = act_arr;

end

function [err_code, varargout] = generic_board(x_size, y_size)
%GENERIC_BOARD brings up a generic board for use in the game.
%   An x and y size are passed in. Board spaces are then layed out in a
%   closed square. They are placed on the main gui screen.
%   EX:
%       generic_board(10,10)

% Define in case we fail in the function.
err_code = -1;

% Get the number of squares total to allocate the size and action arrays.
squares_size = (x_size *2) + ((x_size-2) *2)
size_arr = zeros(squares_size, 4);
act_arr = zeros(squares_size, 1);

% Determine the size of the squares
sq_size = 10;
scrsz = get(0,'ScreenSize');
string_arr = {'+2'; '+4'; 'Fin'; '-2'; '-4';...
    'To Start'; '-Turn'; 'Roll';...
    '-Turn -3'; 'Roll +3'};

% Using shapes and groupings of rectangles is appealing but takes longer to
% access a size array and action array for each position.
% Place rectangles in an outline of a square going counterclockwise.
% The current rect is saved to size_arr everytime along with a random
% action so that we can map out the squares.
count = 1;
for(R = 1:y_size)
    y_pos = (y_size*sq_size) - (sq_size* (R-1))-9;
    gen_rect(1, y_pos);
    % Store size for later token movement
    size_arr(count,:) = [1, y_pos, sq_size, sq_size];
    % Store action for mapping to token placment
    act_arr(count) = randi(10);
    count = count + 1;
    
    x_pos = 1 + (scrsz(4)/840);
    y_pos = y_pos + (scrsz(4)/210);
    if (R == 1)
        text(x_pos, y_pos, 'Start', 'color', 'b',  'FontName', 'Verdana');
    else
        [one_str, two_str] = strtok(string_arr(abs(act_arr(R))),' ');
        text(x_pos, y_pos, char([one_str;two_str]), 'color',...
            'b', 'FontName', 'Verdana');
    end
end
for(R = 1:(x_size-1))
    x_pos = 1 + (sq_size* R);
    y_pos = y_size - 9;
    gen_rect(x_pos, y_pos);
    size_arr(count,:) = [x_pos, y_pos sq_size, sq_size];
    act_arr(count) = randi(10);
    count = count + 1;
    
    x_pos = x_pos + (scrsz(4)/840);
    y_pos = y_pos + (scrsz(4)/210);
    [one_str, two_str] = strtok(string_arr(abs(act_arr(R))),' ');
    text(x_pos, y_pos, char([one_str;two_str]), 'color',...
        'b', 'FontName', 'Verdana');
end
for (R = 1:(y_size-1))
    y_pos = (y_size-9) + (sq_size* R);
    x_pos = (x_size*sq_size)-9;
    gen_rect(x_pos, y_pos);
    size_arr(count,:) = [x_pos, y_pos, sq_size, sq_size];
    act_arr(count) = randi(10);
    count = count + 1;
    
    x_pos = x_pos + (scrsz(4)/840);
    y_pos = y_pos + (scrsz(4)/210);
    [one_str, two_str] = strtok(string_arr(abs(act_arr(R))),' ');
    text(x_pos, y_pos, char([one_str;two_str]), 'color',...
        'b', 'FontName', 'Verdana');
end
for (R = 1:(x_size-2))
    x_pos = (x_size*sq_size)-(sq_size* R)-9;
    y_pos = (y_size*sq_size)-9;
    gen_rect(x_pos, y_pos);
    size_arr(count,:) = [x_pos, y_pos, sq_size, sq_size];
    act_arr(count) = randi(10);
    count = count + 1;
    
    x_pos = x_pos + (scrsz(4)/840);
    y_pos = y_pos + (scrsz(4)/210);
    if (R == (x_size-2))
        text(x_pos, y_pos, 'Fin', 'color', 'b',  'FontName', 'Verdana');
    else
        [one_str, two_str] = strtok(string_arr(abs(act_arr(R))),' ');
        text(x_pos, y_pos, char([one_str;two_str]), 'color',...
            'b', 'FontName', 'Verdana');
    end
end

% Assign outputs now that everything is set up
err_code = 0;
varargout{1} = size_arr;
varargout{2} = act_arr;

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
