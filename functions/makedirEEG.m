%% Function: makdirEEG()
% Author: Will Decker
% Usage: create directories needed for ERP
% Inputs 
    % none

function [rawdir, workdir, txtdir, erpdir] = makedirEEG

curdir = pwd; % identify MATLAB's current directory

%% Create directories

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
    
    varargout{1} = rawdir;
    varargout{2} = workdir;
    varargout{3} = txtdir;
    varargout{4} = erpdir;

else

    disp(["Error...please execute makedirEEG again."])

end



