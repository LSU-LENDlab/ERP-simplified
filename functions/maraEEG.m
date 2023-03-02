%% Function: maraEEG(subject_start, subject_end, subjects, workdir)
% Author: Will Decker
% Usage: run MARA to identify and remove artifacts/bad components

%% Inputs 

%{ 
    subject_start: subject file to start loading (the position of the file name in subject_names
     
    subject_end: last subject file to load (the position of the file name in subject_names
    
    subjects: a str list of subject names to be loaded into the EEG object
    
    workdir: path to working directory

%}

function [EEG, com] = maraEEG(subject_start, subject_end, subjects, workdir)

EEG = [];
com = ' ';

for s = subject_start : subject_end
    subject = subjects{s};

% establish data objects
[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
eeglab('redraw');

% load ICA set
EEG = pop_loadset ([subject '_ICA.set'], workdir);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

% run MARA and identify components
[ALLEEG, EEG, EEG.reject.gcompreject ] = processMARA (ALLEEG, EEG,CURRENTSET) ;

% remove components 0.5 probability or greater that fall within the first
% 10 components marked for removal

remove_components = EEG.reject.MARAinfo.posterior_artefactprob(1:10) > 0.5;
EEG = pop_subcomp( EEG, find(remove_components), 0);
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',[subject '_ICA_clean'],'gui','off');
EEG = eeg_checkset( EEG );

% save new dataset
EEG = eeg_checkset( EEG ) ;
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET ) ;
EEG = pop_saveset( EEG, [subject '_ICA_clean'], workdir);

end