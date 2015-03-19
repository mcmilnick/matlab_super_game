function [tok_handle, text_handle] = update_token(size_arr, player_info,...
    fig_handle, player_turn, tok_handle, text_handle)
%UPDATE_TOKEN updates the position of the token.
%   This function first deletes the token fom before and then reads in the
%   new position to replace a token.

if (player_info(player_turn).player_pos > length(size_arr))
    player_info(player_turn).player_pos = length(size_arr)
end

delete(tok_handle{player_turn});
delete(text_handle{player_turn});

color_mat = [0.5 0.5 0.1];
scrsz = get(0,'ScreenSize');
if (isempty(fig_handle{player_turn}))
    %Update with default token
    cur_coord = size_arr(player_info(player_turn).player_pos,:);
    x_pos = cur_coord(1) + (scrsz(4)/420);
    y_pos = cur_coord(2) + (scrsz(3)/200);
    tok_handle = rectangle('Position',cur_coord, 'FaceColor', color_mat,...
        'EdgeColor', [0.9 0.1 0.1], 'LineWidth', 2);
    text_handle = text(x_pos, y_pos, ['P' num2str(player_turn)], 'color',...
        'b', 'FontName', 'Verdana');
else
    %Use custom token
        %Use custom token - This functionality has been commented out here
        %and recinded elsewhere. You can read in the folder and I wanted
        %the code visible because I spent a good while on it, but in the
        %end it doesn't scale well with other screens. This is kind of a
        %big deal to me because it could be solved with calling the gui as
        %normalized for fixed size, but this would mean it doesn't fit on
        %everyone's computers, which is extremely annoying. I have had so
        %many customer complaints at work about our software doing exactly
        %that.
    %cur_coord = size_arr(player_info(player_turn).player_pos,:);
    %x_pos = cur_coord(1) + (scrsz(4)/420);
    %y_pos = cur_coord(2) + (scrsz(3)/200);
    %im_x = (scrsz(3)*cur_coord(1))/3.3;
    %im_y = (scrsz(4)*cur_coord(2))/95;
    %set(new_tok,'Visible','on', 'Position',[im_x im_y (4*cur_coord(3)) (4*cur_coord(4))],...
    %    'cdata',fig_handle{player_turn});
    %tok_handle = rectangle('Position',cur_coord, 'FaceColor', color_mat,...
    %    'EdgeColor', [0.9 0.1 0.1], 'LineWidth', 2);
    %text_handle = text(x_pos, y_pos, ' ', 'color',...
    %    'b', 'FontName', 'Verdana');
end

end
