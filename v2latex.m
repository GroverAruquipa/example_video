function v2latex(name_video,Folder_name,Frame_name,N_F,RES,im_focus)

%   RES = resolution of picture: RES > 0   (recomended RES > 100)
%   N_F = Desired number of frames
%
%   im_focus = [[ax Lx] [ay Ly]]  %  introduce im_focus = [];  to get the complete frame
%  
%   [ax Lx] = porcentual value (between 0-1) for x-axis
%   [ay Ly] = porcentual value (between 0-1) for y-axis
%
%
%                   Frame scheme
%  (0,0) _________________________________________
%       |        ^                                |
%       |        |         Neglected              |
%       |       ay           zone                 |
%       |        |                                |
%       |        v                                |
%       |<--ax-->.<---------Lx---------->         |
%       |        ^                      |         |
%       |        |                      |         |                
%       |        |        saved         |         |
%       |     Ly |         zone         |         |
%       |        |                      |         |
%       |        |                      |         |
%       |        v______________________|         |
%       |                                         |
%       |                                         |
%       |                                         |
%       |_________________________________________|
%                                                  (1,1)

v = VideoReader(name_video);
N=v.NumFrames;

sel_frame = ceil(linspace(1,N,N_F));

for i=1:N_F

    DIR = pwd; files = dir(DIR);   dirlog = [files.isdir]; sf = files(dirlog); % find the video
    sfnames = {sf(3:end).name};    Flag = zeros(1,length(sfnames));
    for j=1:length(sfnames)
        Flag(j) = strcmp(sfnames{j},Folder_name);
    end
    if sum(Flag)==0; mkdir(Folder_name); end
    cd(strcat(DIR,'\',Folder_name))
    %
    current_frame = read(v,sel_frame(i));     sz=size(current_frame,[1 2]);
    if isempty(im_focus)
        current_frame2 = current_frame;
    else
        vx = ceil(sz(2)*im_focus(1)+1:sz(2)*(im_focus(1)+im_focus(2)));
        vy = ceil(sz(1)*im_focus(3)+1:sz(1)*(im_focus(3)+im_focus(4)));
        current_frame2 = current_frame(vy,vx,:);
    end
    
    fig=figure(1e5); %set(fig,Visible=="off");
    imshow(current_frame2);      ax = gca;
    exportgraphics(ax,strcat(Frame_name,'_',num2str(i),'.png'),'Resolution',RES) %changed to jpg, etc %% We are still in process to attach the .eps format for the super resolution
    cd(DIR)
    close(1e5)

end
