function [err_code, figure_handle] = import_token(in_name)

close all
% example name - 'new_pic.jpg'
im=imread(in_name);
clf
axes('position',[0,0.9,0.1,0.1])
imshow(im)

err_code = 0;
figure_handle = im;

end