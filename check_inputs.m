function [board_choice, die_choice] = check_inputs()
%CHECK_INPUTS checks user inputs as corresponds with the check inputs
%state in our architecture
%   The function of this script is to ask questions of the user on how the
%   game will run. The variables addressed are on if the user wants a
%   custom board and die, or the geneic ones. These choices are then
%   returned for later use.
%   EX:
%       [board_choice, die_choice] = check_inputs()
%          board_choice = 1
%          die_choice = 2

% Board choice
fprintf('Would you like to use a generic board, or your own?\n');
board_choice = menu('Board choice', 'Own Board', 'Generic Board');

% Die choice
fprintf('Would you like a generic die(may be loaded), or your own?\n');
die_choice = menu('Die choice', 'Own die', 'Generic die');

end
