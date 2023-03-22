%%
%% Main function 
clc , close all , clear all
% Parameters of the video
name_video  = 'parallelhand.avi';
Folder_name = 'parallelhand';
Frame_name  = 'parallelhand';


N_Frames = 52;  % desired number of frames
Resolution = 90; % resolution 
%im_focus = [[0.32 0.52] [0 1]]; % see function description 
im_focus = [[0 0.8] [0.15 0.65]]; % see function description video4
%im_focus = [[0 1] [0.25 0.75]]; % see function description video1, 2, 3

v2latex(name_video,Folder_name,Frame_name,N_Frames,Resolution,im_focus)






















