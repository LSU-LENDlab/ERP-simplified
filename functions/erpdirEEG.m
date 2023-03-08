%% Function: erpdirEEG()
% Author: Will Decker
% Usage: select ERP directory
% Inputs 
    % none

%%
function erpdir = erpdirEEG

uiwait(msgbox('Select the folder with your ERP data and output. This will serve as your ERP directory','modal'));
erpdir = uigetdir;

if erpdir == 0

    disp('Please select the folder for your ERP directory')

else

    disp(['You have selected ', erpdir, ' as your ERP directory'])

end