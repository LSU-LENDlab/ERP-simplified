%% Function: workdirEEG()
% Author: Will Decker
% Usage: select working directory
% Inputs 
    % none

%%
function workdir = workdirEEG

uiwait(msgbox('Select the folder for your working data analysis. This will serve as your working directory','modal'));
workdir = uigetdir;

if workdir == 0

    disp('Please select the folder for your working directory')

else

    disp(['You have selected ', workdir, ' as your working directory'])

end