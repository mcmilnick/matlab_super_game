function [err_code] = own_board(  )
%OWN_BOARD brings in the user created board for use in the game.
%   Detailed
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

% Layout board for further placement of tiles
board_layout(100,100);

% Read in text file for board pieces
% TBD: Experiment
R = 1;
while(~feof(fid))
    rec_lin = fgetl(fid);
    rect_arr(R) = str2double(rec_lin);
    R = R + 1;
end

board_in_cell{1}(R)
% Start with rectangles
rectangle('Position', , 'FaceColor', [], 'EdgeColor', [], 'LineWidth', );

fclose(fid);

end

