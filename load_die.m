function [err_code] = load_die(die_choice)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Switch case for finding the die choice. Grabs from gui handle.
switch get(get(hBtnGrp2,'SelectedObject'),'Tag')
    case 'ud'
        die_choice = 2;
    case 'gd'
        die_choice = 3;
    otherwise
        die_choice  = -1;
end

end

