function [player_arr] = get_user_names(hEdit1, hEdit2, hEdit3, hEdit4)

player_arr = cell(4,1);
player_arr{1} = get(hEdit1, 'String');
player_arr{2} = get(hEdit2, 'String');
player_arr{3} = get(hEdit3, 'String');
player_arr{4} = get(hEdit4, 'String');

end
