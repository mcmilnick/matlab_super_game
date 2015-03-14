function [] = own_die()

fid = fopen('dice_roll_1.txt');
die_rolls = textscan(fid, '%s', 'delimiter', '0');
player_one_rolls = die_rolls{1}{1};
player_two_rolls = die_rolls{1}{1};

fclose(fid);

end