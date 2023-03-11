%% ERP_simplified

% Author: Will Decker

%% Introduction

%{
The following script and functions combine and completely automate the standard analysis steps for preprocessing raw EEG data and extracting ERPs. 
This pipeline makes use of EEGLAB, ERPLAB and MARA--open source software for analyzing EEG data. 
Additionally, this pipeline is specified for raw BrainVision files but can be modified to accomodate other file types. 
Please review this document for a detailed description for ERP-Simplified implementation.

ERP-Simplified is important because it removes subjectivity among researchers during important analysis steps when working with EEG.
%}

%% Overview

% Step 1: Establish directories
% Step 2: Establish parameters
% Step 3: Establish subject list
% Step 4: Data preprocessing
% Step 5: ICA
% Step 6: Artifact removal
% Step 7: Creating a binlist
% Step 8: ERP analysis
% Step 9: Average ERPs

%%
clear
eeglab;

%% Step 1: Establish directories

rawdir = rawdirEEG % The 'rawdir' is where MATLAB will pull raw EEG data from
workdir = workdirEEG % The 'workdir' is an active directory that MATLAB will send all working data to
txtdir = txtdirEEG % 'txtdir' is for textfiles and binlists
erpdir = erpdirEEG % The 'erpdir' is where ERPs will be sent

%% Step 2: Establish parameters

% Filters
lowpass = 30; % can be changed as needed
highpass = 0.1; % can be changed as needed

% Epochs
epoch_baseline = -200.00; % can be changed as needed
epoch_end = 800.00; % can be changed as needed

%% Step 3: Establish subject list

[d,s,r] = xlsread([txtdir filesep 'subjects.xlsx']); % the 'subjects.xlsx' MUST be in you text directory
subjects = r;
numsubjects = (length(s));

%% Step 4: Choosing which subject(s) to run

% Subjects to run
subject_start = 1; % subject in position 'x' in subjects variable
subject_end = 1; % subject in position 'x' in subjects variable

%% Step 5: Data preprocessing
% to read more about the function 'preprocessEEG' highlight it and press
% cmd + shift + D (on Mac)

preprocessEEG(subject_start, subject_end, subjects, workdir, rawdir, highpass, lowpass)

%% Step 6: ICA
% to read more about the function 'icaEEG' highlight it and press cmd +
% shift + D (on Mac)

icaEEG(subject_start, subject_end, subjects, workdir)

%% Step 7: Artifact Removal
% to read more about the function 'maraEEG' highlight it and press cmd +
% shift + D (on Mac)

threshold = 0.5; % can be changed as need

maraEEG(subject_start, subject_end, subjects, workdir, threshold)

%% Step 8: Creating a binlist 

%{
A binlist is a .txt file that you will put in your 'txtdir'. The following 
steps of ERP-simplified cannot be run without a binlist.
This file is what MATLAB uses to identify where ERPs will be extracted (i.e. the
stimulus locations indetified by trigger codes). 
Let's say I have two visual stimuli presented in an experiment and I want 
to extract the ERP from these stimuli. The trigger codes are 
101 and 102. The bin list will look something like this:

Example:        bin 1
                bin descriptor
                .{101}
                bin 2
                bin descriptor
                .{102}
%}
           
%% Step 9: ERP analysis
% to read more about the function 'erpanalysisEEG' highlight it and press
% cmd + shift + D (on Mac)

erpanalysis(subject_start, subject_end, subjects, workdir, txtdir, epoch_baseline, epoch_end)

%% (Optional step): Editing eventlist using terminal

%{ 

EEGLAB creates an uneditable header in your eventlist which can make it
difficult to analyize your behavioral data later on. This section of code removes that header
using macOS terminal and bash code

for this section of code, make sure you have downloaded
"edit_bin_list.sh" and saved it to your txtdir (NOTE: there are minor
instructions included within this file)

Open terminal and cd into your txtdir where the binlists have been saved
In terminal type sh edit_bin_list.sh

%} 
%% Step 10: Average ERPs
% to read more about the function 'erpaverageEEG' highlight it and press
% cmd + shift + D (on Mac)

erpaverageEEG(subject_start, subject_end, subjects, workdir, erpdir)

