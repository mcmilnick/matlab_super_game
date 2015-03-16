function final_proj_gui()
% Main run occurs from gui. This must be a function to prevent infinite
% recrsion.
% Each function will correspond to a single state in our architecture.
% The first state is entering the program. Congratulations on this momentus
% ocassion.

clear;

scrsz = get(0,'ScreenSize');
% Make figure based off of screen size
% Keep figure off until everything is set
game_gui = figure('Visible','off', 'Menu','none', 'Name','Board Game',...
    'Position',[0 -50 scrsz(3) scrsz(4)]);
handles = guidata(game_gui); 
guidata(game_gui, handles);

% Keep aspect ratio with current window
daspect([1,1,1]);
% Rid the board of the defaut axis
axis off;

hBtnGrp = uibuttongroup('Visible','on',...
              'Position',[0 .8 .1 1],...
              'SelectionChangedFcn',@button2_callback,...
              'Units','Normalized');
          
hBtnGrp2 = uibuttongroup('Visible','on',...
                  'Position',[.1 .8 .1 1],...
                  'SelectionChangedFcn',@button2_callback);
      
uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[15 90 110 30], 'String','User Board', 'Tag','ub')
uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[15 60 110 30], 'String','Generic Board', 'Tag','gb')
uicontrol('Style','Radio', 'Parent',hBtnGrp2, 'HandleVisibility','off', 'Position',[15  90 110 30], 'String','User Die', 'Tag','ud')
uicontrol('Style','Radio', 'Parent',hBtnGrp2, 'HandleVisibility','off', 'Position',[15  60 110 30], 'String','Generic Die', 'Tag','gd')

uicontrol('Style','pushbutton', 'String','Start Game', 'Position',[(scrsz(3)/2) 100 60 25],'Callback',{@button_callback})

uicontrol('Style','text',...
          'String','Enter Player Names',...
          'Position',[300 (scrsz(4)-50) 120 20]);
            
hEdit1 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)-75) 120 20], 'String','Player 1');
hEdit2 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 100) 120 20], 'String','Player 2');
hEdit3 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 125) 120 20], 'String','Player 3');
hEdit4 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 150) 120 20], 'String','Player 4');
set(game_gui, 'Visible','on')

button_callback(hEdit1, hEdit2, hEdit3, hEdit4, hBtnGrp, hBtnGrp2);

end

% Callback for startgame
function button_callback(hEdit1, hEdit2, hEdit3, hEdit4, hBtnGrp, hBtnGrp2)
% ***************************************************************
% Start of game
% ***************************************************************
% This callback for startgame passes all user handles.
% We use radio buttons to decide the run conditions of the board game.
% These buttons decide the players, the board to use, and the die to use.
% The player names also have an edit styled gui, and therefore we can grab
% the strings.

% Call main function to utilize the buttons
[player_names] = get_user_names(hEdit1,hEdit2, hEdit3, hEdit4);

% Based on the user choice, load the board. The error code is returned to
% indicate a load error. -1 corresponds to an error. Do the same for die.
[err_code] = load_board(hBtnGrp);
[err_code] = load_die(hBtnGrp2);

end