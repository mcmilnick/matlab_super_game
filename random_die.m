function [player_one_rolls , player_two_rolls ] = random_die(  )
%If user does not have own dice, a random die will be
%provided
%   Detailed explanation goes here

%Player 1 dice rolls
n = 20;
%I don't know how to modularize this part of the code
%Because I don't know how to implement the number of 
%Turns.
die_sequence = [];
for m = 1:n
    die = randi([1,6]);
    die_sequence =  [die_sequence die];
end
player_one_rolls = die_sequence;
%Player 2 dice rolls
n = 20;
die_sequence = [];
for m = 1:n
    die = randi([1,6]);
    die_sequence = [die_sequence, die];
end
player_two_rolls = die_sequence;

end

