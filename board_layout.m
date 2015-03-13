function [ fig ] = board_layout( x_grid, y_grid )
%BOARD_LAYOUT Creates a board layout for use in making a board game.
%   The function obtains the screen size and creates a figure to use as the
%   board space. The grid is then set and scaled accordingly.
%   EX:
%   board_layout(100,100);

% Get the screen size and use it to create a figure.
scrsz = get(0,'ScreenSize');
figure('Position',[0 -50 scrsz(3) scrsz(4)], 'Color', [0.7 0.8 0.9]);

% Set up the coordinate system using the input sze. This is variable in
% case users care to use the function with variable scaling.
axis([0 x_grid 0 y_grid]);
axis ij;

% Ensure equal scaling in both axes.
daspect([1,1,1]);

% Truly the axis did not need to be turned on in this function as it is
% more of a development tool, but to adhere to the HW guidlines it will be
% turned on and off.
axis off;

%Return the handle of the current figure so that the user may access
%information such as the figure number.
fig = gcf;

end

