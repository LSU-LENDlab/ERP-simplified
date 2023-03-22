%% Function: makdirEEG()
% Author: Will Decker
% Usage: create directories needed for ERP-Simplified
% Inputs 
    % none

function varargout = makedirEEG(  )

curdir = pwd; % identify MATLAB's current directory

rawdir = fullfile(curdir, 'rawdir');
mkdir(rawdir); % make empty folder for raw data

workdir = fullfile(curdir, 'workdir');
mkdir(workdir); % make empty folder for work data

txtdir = fullfile(curdir, 'txtdir');
mkdir(txtdir); % make empty folder for text data

erpdir = fullfile(curdir, 'erpdir');
mkdir(erpdir); % make empty folder for ERP data

% Output the paths to the command window

disp(['rawdir: ' rawdir]);
disp(['workdir: ' workdir]);
disp(['txtdir: ' txtdir]);
disp(['erpdir: ' erpdir]);

%% Assign output to variables

if nargout > 0

disp(['rawdir: ' rawdir]);
disp(['workdir: ' workdir]);
disp(['txtdir: ' txtdir]);
disp(['erpdir: ' erpdir]);

    varargout{1} = rawdir;
    varargout{2} = workdir;
    varargout{3} = txtdir;
    varargout{4} = erpdir;

    disp(["..."])
    disp(["You have successfully created your directories."])

else
    disp(["..."])
    disp(["Error...please execute makedirEEG again."])

end



