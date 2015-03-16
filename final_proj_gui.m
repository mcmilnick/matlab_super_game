%************************************************************************
% Start GUI
%************************************************************************
function final_proj_gui()
% Main run occurs from gui. This must be a function to prevent infinite
% recrsion. This calls the initialization function. Each subsequent
% function will correspond to a single state in our architecture.
% The first state is entering the program. Congratulations on this momentus
% ocassion.
% UI control stuff is generally boilerplate code, but this was started from
% scratch without using the predefined functions from the gui GUIDE. This
% was done because the final is all about coding in Matlab.

clear;

% Make figure based off of screen size
scrsz = get(0,'ScreenSize');
% Set figure handle, size of the gui, and keep the figure off until
% everything is set
game_gui = figure('Visible','off', 'Menu','none', 'Name','Board Game',...
    'Position',[0 -50 scrsz(3) scrsz(4)]);
% Keep aspect ratio with current window
daspect([1,1,1]);
% Rid the board of the defaut axis
axis off;

% Create a button group for the board so they are grouped together and can
% be accessed to find which one was chosen.
board_radio = uibuttongroup('Visible','on',...
              'Position',[.1 .8 .1 1],...
              'SelectionChangedFcn',@board_choice_callback,...
              'Units','Normalized');
      
% Create radio buttons for choosing the board. There is a generic and user
% board mode
uicontrol('Style','Radio', 'Parent',board_radio, 'HandleVisibility','off',...
    'Position',[15 90 110 30], 'String','User Board', 'Tag','ub')
uicontrol('Style','Radio', 'Parent',board_radio, 'HandleVisibility','off',...
    'Position',[15 60 110 30], 'String','Generic Board', 'Tag','gb')


% Create a button group for the die so they are grouped together and can be
% accessed to find which one was chosen.
die_radio = uibuttongroup('Visible','on',...
                  'Position',[.2 .8 .1 1],...
                  'SelectionChangedFcn',@die_choice_callback);
              
% Create radio buttons for choosing the die. There is a generic and user
% die mode
uicontrol('Style','Radio', 'Parent',die_radio, 'HandleVisibility','off',...
    'Position',[15  90 110 30], 'String','User Die', 'Tag','ud')
uicontrol('Style','Radio', 'Parent',die_radio, 'HandleVisibility','off',...
    'Position',[15  60 110 30], 'String','Generic Die', 'Tag','gd')

% First put in text to show where to enter your name
uicontrol('Style','text',...
          'String','Enter Player Names',...
          'Position',[15 (scrsz(4)-50) 120 20]);

% Now put in the edit spaces for entering names.
name_1 = uicontrol('Style','edit', 'Position',[15 (scrsz(4)-75) 120 20],...
    'String','Player');
name_2 = uicontrol('Style','edit', 'Position',[15 (scrsz(4)- 100) 120 20],...
    'String','Player');
name_3 = uicontrol('Style','edit', 'Position',[15 (scrsz(4)- 125) 120 20],...
    'String','Player');
name_4 = uicontrol('Style','edit', 'Position',[15 (scrsz(4)- 150) 120 20],...
    'String','Player');

% Board load button - Allows user to select board file.
board_file = uicontrol('Style','pushbutton', 'String','Select Board File', 'Position',...
    [(scrsz(4)*.18) (scrsz(4)-200) 90 25],'Callback',{@board_load_callback})

% Die load button - Allows user to select die file.
die_file = uicontrol('Style','pushbutton', 'String','Select Die File', 'Position',...
    [(scrsz(4)*.36) (scrsz(4)-200) 90 25],'Callback',{@die_load_callback})

% Bring up the button to start the game. Has an associated callback
% function. This passes handles when the button is pressed to go to the
% game initialization function.
uicontrol('Style','pushbutton', 'String','Start Game', 'Position',...
    [(scrsz(3)/2) 100 60 25],'Callback',{@game_setup_callback, name_1,...
    name_2, name_3, name_4, board_radio, die_radio, board_file, die_file})
          
% Makes the gui visible now that it is set up.
set(game_gui, 'Visible','on')

end

% ************************************************************************
% Initialization of game
% ************************************************************************
% This callback for startgame passes all user handles. It is star because
% the user does not need to know about initialization,
% We use radio buttons to decide the run conditions of the board game.
% These buttons decide the players, the board to use, and the die to use.
% The player names also have an edit styled gui, and therefore we can grab
% the strings.
function game_setup_callback(src, ev, name_1, name_2, name_3, name_4,...
    board_radio, die_radio, board_file, die_file)

% Turn off visibility from the buttons so  users can't conflict.
set(board_radio, 'Visible','off');
set(die_radio, 'Visible','off');
set(src,'Visible','off');
set(board_file,'Visible','off');
set(die_file,'Visible','off');

% Call main function to utilize the buttons
[player_names, length_play] = get_user_names(name_1,name_2, name_3, name_4);
% Now the decision could be made to put this in a struct and pass that to
% give a player their own die. This however would involve passing a struct,
% which is generally a bad idea unless you use pointers... I don't like
% Matlab pointers.

% Disable the names to lock them
set(name_1, 'enable', 'off')
set(name_2, 'enable', 'off')
set(name_3, 'enable', 'off')
set(name_4, 'enable', 'off')

% Set board file name
board_file_name = board_file.UserData;
% Based on the user choice, load the board. The error code is returned to
% indicate a load error. -1 corresponds to an error. Do the same for die.
[err_code, size_arr, act_arr] = load_board(board_radio, board_file_name);
% Check for errors
if (err_code == -1)
    fprintf('Board did not load properly.\n');
    reset_gui();
end

% Set die file name
die_file_name = die_file.UserData;
% The die function returns a cell matrix with the die rolls. There are a
% max of four player die groups. If a file is read in with less than four
% columns, the rest are blank. This means if more than four players give a
% name, they can play with generic die. If more than four die groups are
% read in though, the ones past four will be disregarded with an error
% message of four max players. Reading the names will determine how many
% are used.
[err_code, die_rolls] = load_die(die_radio, length_play, die_file_name);
if (err_code == -1)
    fprintf('Die did not load properly.\n');
    reset_gui();
end

%TBD - Insert tokens
start_game(player_names, size_arr, act_arr, die_rolls);

end

%TBD - comment
function start_game(player_names, size_arr, act_arr, die_rolls)
%TBD - start game
end

%**********************************************************************
% Callback functions
%**********************************************************************
function board_load_callback(src,ev)
%BOARD_LOAD_CALLBACK grabs the pushbutton handle, allows the user to
%specify the board to use, then stores this as a string in the UserData
%section of the UI Control group. This is in essence one large struct for
%the pushbutton which we are commandeering.
[board_file, board_dir] = uigetfile('.txt');
board_full = [board_dir board_file];
set(src, 'UserData', board_full)

end

function die_load_callback(src,ev)
%DIE_LOAD_CALLBACK grabs the pushbutton handle, allows the user to
%specify the die to use, then stores this as a string in the UserData
%section of the UI Control group. This is in essence one large struct for
%the pushbutton which we are commandeering.
[die_file, die_dir] = uigetfile('.txt');
die_full = [die_dir die_file];
set(src, 'UserData', die_full)

end

%**********************************************************************
% Reset GUI function
%**********************************************************************
function reset_gui()
%RESET_GUI resets the gui by closing the current figure and running again.
%   While this may not seem like the proper way, merely returning to the
%   original gui requires returning and reseting. This method is however
%   flawed in the case of the figure handle being destroyed. This is the
%   safer option without spending a full week diving into the Java code
%   making the GUI and finding if a return and reset is thread safe.
    close(gcf);
    final_proj_gui();
end