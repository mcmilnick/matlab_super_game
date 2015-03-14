function [ fig ] = board_layout()
%BOARD_LAYOUT Creates a board layout for use in making a board game.
%   The function obtains the screen size and creates a figure to use as the
%   board space. The grid is then set and scaled accordingly.
%   EX:
%   board_layout();

% Get the screen size and use it to create a figure.
scrsz = get(0,'ScreenSize');
figure('Position',[0 -50 scrsz(3) scrsz(4)], 'Color', [0.7 0.8 0.9]);

% Ensure equal scaling in both axes.
daspect([1,1,1]);

% Rid the board of the defaut axis
axis off;

%Return the handle of the current figure.
fig = gcf;

end

