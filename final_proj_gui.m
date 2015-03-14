function final_proj_gui
scrsz = get(0,'ScreenSize');
% Make figure based off of screen size
% Keep figure off until everything is set
hFig = figure('Visible','off', 'Menu','none', 'Name','Board Game',...
    'Position',[0 -50 scrsz(3) scrsz(4)], 'Color', [0.7 0.8 0.9]);
% Keep aspect ratio with current window
daspect([1,1,1]);
% Rid the board of the defaut axis
axis off;

hBtnGrp = uibuttongroup('Visible','on',...
              'Position',[0 .8 .1 1],...
              'SelectionChangedFcn',@button_callback,...
              'Units','Normalized');
          
hBtnGrp2 = uibuttongroup('Visible','on',...
                  'Position',[.1 .8 .1 1],...
                  'SelectionChangedFcn',@button2_callback);
      
uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[15 90 110 30], 'String','User Board', 'Tag','ub')
uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[15 60 110 30], 'String','Generic Board', 'Tag','gb')
uicontrol('Style','Radio', 'Parent',hBtnGrp2, 'HandleVisibility','off', 'Position',[15  90 110 30], 'String','User Die', 'Tag','ud')
uicontrol('Style','Radio', 'Parent',hBtnGrp2, 'HandleVisibility','off', 'Position',[15  60 110 30], 'String','Generic Die', 'Tag','gd')

uicontrol('Style','pushbutton', 'String','Start Game', 'Position',[200 50 60 25],'Callback',{@button_callback})

player_text = uicontrol('Style','text',...
                'String','Enter Player Names',...
                'Position',[300 (scrsz(4)-50) 120 20]);
            
hEdit1 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)-75) 120 20], 'String','Player 1');
hEdit2 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 100) 120 20], 'String','Player 2');
hEdit3 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 125) 120 20], 'String','Player 3');
hEdit4 = uicontrol('Style','edit', 'Position',[300 (scrsz(4)- 150) 120 20], 'String','Player 4');

set(hFig, 'Visible','on')
    % Board callback
    function button_callback(src,ev)
        v1 = str2double(get(hEdit1, 'String'));
        v2 = str2double(get(hEdit2, 'String'));
        
        v3 = str2double(get(hEdit3, 'String'));
        v4 = str2double(get(hEdit4, 'String'));
        % Switch case for loading the board
        switch get(get(hBtnGrp,'SelectedObject'),'Tag')
            case '+',  res = v1 + v2;
            case '-',  res = v1 - v2;
            case '*',  res = v1 * v2;
            case '/',  res = v1 / v2;
            otherwise, res = '';
        end
        % Switch case for loading the die
        switch get(get(hBtnGrp,'SelectedObject'),'Tag')
            case '+',  res = v1 + v2;
            case '-',  res = v1 - v2;
            case '*',  res = v1 * v2;
            case '/',  res = v1 / v2;
            otherwise, res = '';
        end
    end
end