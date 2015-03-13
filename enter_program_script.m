% This is the enter program script
% Ask questions on game run

success_open = 0;

% First, board choice
fprintf('Would you like to use a randomly generated board, or your own.');
user_choice = menu('Board choice', 'Own Board', 'Random Board');

% Switch of two cases acts as a hash map which is slower than if else, but
% conforms to better style.
switch user_choice
    case 1
        % Own board
        %TBD: check error code
        success_open = own_board();
    case 2
        % Random board
        success_open = random_board();
    otherwise
        fprintf('You have chosen to exit the game :(\n');
end
