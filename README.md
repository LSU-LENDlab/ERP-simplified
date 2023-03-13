# ERP-Simplified
Author: Will Decker

The following script and functions combine and completely automate the standard analysis steps for preprocessing raw EEG data and extracting ERPs. This pipeline makes use of EEGLAB, ERPLAB and MARA--open source software for analyzing EEG data. Additionally, this pipeline is specified for raw BrainVision files but can be modified to accomodate other file types. Please review this document for a detailed description for ERP-Simplified implementation.

ERP-Simplified is important because it removes subjectivity among researchers during important analysis steps when working with EEG.

## Table of Contents

* Introduction
* Step 1: Establish directories
* Step 2: Establish parameters
* Step 3: Establish subject list
* Step 4: Choosing which subjects to run
* Step 5: Data preprocessing
* Step 6: ICA
* Step 7: Artifact removal
* Step 8: Creating a binlist
* Step 9: ERP analysis
* Step 10: Average ERPs


## Introduction

To begin working with ERP-simplified:

1. Download the [functions](https://github.com/w-decker/ERP-simplified/blob/main/functions) and add it to your MATLAB path.
2. Open [ERP_simplified.m](https://github.com/w-decker/ERP-simplified/blob/main/ERP_simplified.m)
3. Ensure that you have installed the following: Matlab Statistics Toolbox, Optimization Toolbox and the Signal Processing Toolbox
4. Read through the entire ERP_simplified.m script. This will help you get a sense of what you are about to complete.
5. Open each file within the functions folder and read through their parameters/inputs to better understand what each function does when implemented.

Additionally, as you progress through each step, the files are saved according to their step in the process. The purpose of this is to provide a safeguard as ERP-Simplified is constantly pulling and pushing new data. You can expand functions to learn more about where you are in each step and the naming scheme that is currently being implemented. 

## Step 1: Establish directories

In the case of ERP-Simplified, directories are essentially folders that contain data. ERP-Simplified makes use of four different directories that you will need to create:

1. raw directory: a folder that contains your raw data.
2. working directory: a folder that ERP-Simplified uses to send all working analyses to.
3. text directory: a folder that contains text data and/or text output
4. erp directory: a folder that contains data and/our ouput necessary for ERP analysis.

ERP-Simplified already contains functions that allow you to choose specific folders and assign them to a corresponding directory. In Step 1, you will notice the following code:

  ```
  rawdir = rawdirEEG
  workdir = workdirEEG
  txtdir = txtdirEEG
  erpdir = erpdirEEG
 ```
If you have already reviewed the functions used in this pipeline you will recognize `rawdirEEG`, `workdirEEG`, `txtdirEEG` and `erpdirEEG`. Essentially, these functions assign a folder to the variable "rawdir", "workdir", etc. NOTE: do not change these variable names as they are repeated throughout the pipeline.

To execute this step, ensure that the Step 1 cell is highlighted by clicking anywhere within the cell and then click "Run Section" or cmd+enter. You will then be prompted to assign a folder to each directory variable.

#### Or

As stated above, ERP-Simplified works using a series of directories that is pulls and pushes data to. In the second iteration of Step 1, ERP-Simplified simply creates the required folders automatically in MATLAB's current working directory. If you wish to see MATLAB's current working directory simply type `pwd` in the command window. The output that you are shown is where the required folders will be created. The only work that you must do is add raw EEG data into the raw directory. Other than that, this is a fast and easy way to create the necessary directories to get started with ERP-Simplified.

To execute this step, ensure that the Step 1 cell is highlighted by clicking anywhere within the cell and then click "Run Section" or cmd+enter.

## Step 2: Establish parameters

When analyzing time-series data, such as EEG data, you will need to filter the data using a highpass and lowpass filter. These values have already been inlcuded in the ERP_simplified.m script and are standard but you may change them at your own discression.

Additionally, you will need to epoch your data. This means that you are dividing your time-series data into chunks of time. ERP_simplified uses as generic epoch of -200ms to 800ms after the onset of a a stimulus but this can be changed as needed.

To execute this step, ensure that the Step 2 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 3: Establish subject list

ERP_simplified analyzes specific EEG files using a subject list or a list of file names to pull and run through the code. It does this with an Excel file.
To properly do this, open Microsoft Excel and in the first column, type the names of each file without a file end. So you must only type, for example. 

- eeg_001
- eeg_002
- etc...

Once you have completed the aforementioned step *save the excel files by the name "subjects" in the folder that you assigned as your text directory.*

To execute this step, ensure that the Step 3 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 4: Choosing which subjects to run

Navigate over to your MATLAB workspace and click on the cell named "s". This is your subject list. To choose which subject(s) to run, select the subjects and type in their position in the cell, "s". For example, if you wish to run eeg_006 and that subject is in position 5 in "s" (perhaps due to eeg_005 dropping out or some other reason) you will type the number "5" next to `subject_start`. If you only wish to run this subject, you will also type "5" next to `subject_end`. If you wish to run multiple subjects after eeg_006 (who is in position 5 in "s") simply look for that last subject that you wish to run and type their position next to `subject_end`. For example, if you want to run all of the subjects from eeg_006 to eeg_045, and eeg_045 is located in position 47 you would type "47" next to `subject_end` and the code will run all of the subjects starting in position 5 through the subject in position 47.

To execute this step, ensure that the Step 4 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 5: Data preprocessing

The function `preprocessEEG` preprocesses your data based on some of the inputs that you have already given like which subjects to run or your highpass/lowpass filters. Overall, it conducts the following processes:

1. loads raw files
2. filter data based on highpass and lowpass filters
3. rereferenece raw data
4. remove extraneous data
5. save file as a new dataset

To execute this step, ensure that the Step 5 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 6: ICA

The function `icaEEG` runs your data throguh an independant component analysis (ICA) this step may take longer than others.

To execute this step, ensure that the Step 6 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 7: Artifact removal

The function `maraEEG` utilizes [MARA](https://github.com/irenne/MARA.git) and requires additional toolboxes to function (see Introduction, step 3). This identifies artifiactes and removes them based on a probability threshold. As you may have noticed, there is an additional variable within this cell called `threshold`. This is value MARA uses to decide which artifacts to remove and which artifacts to keep. Additionally, `maraEEG` only removes artifacts from its first 10 artifacts. An example of how `maraEEG` works:

```
threshold = 0.5;

maraEEG(subject_start, subject_end, subjects, workdir, threshold)
```
MARA will remove any components that are 50% likely or more to be a true artifact and it will only remove these within the first 10 marked components. If there are additionaly components that MARA has marked and do not have a probabilty of 0.5 or higher, then they will be retained in the data. This is important because removing too much brain data may not be beneficial. It is important to only remove what is needed and to keep as much brain data intact as possible.

To execute this step, ensure that the Step 7 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 8: Creating a binlist

This step must be conducted manually.

A binlist is a .txt file that you will put in your text directory. The following 
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
                
NOTE: this document must be saved in a .txt format and placed in the text directory.

## Step 9: ERP analysis

This step is the first component to ERP analysis and relies on the binlist, your epoch start and epoch end as well as other information. The following steps are implemented by `erpanalysisEEG`.

1. create eventlist 
2. apply binlister
3. extract epochs
4. export event list
5. make epochs with peak activity within window

To execute this step, ensure that the Step 9 cell is highlighted by clicking anywhere within the cell and then click "Run Section".

## Step 10: Average ERPs

This is the final step in the ERP-Simplified analysis.

The function `erpaverageEEG` conducts the following steps:

1. average ERPs
2. filter ERPs

NOTE: there are additional steps that must be taken to statistically analyze your data; however, those steps can be done without the guidance and structure that ERP-Simplified offers. 


For now, that is all! Thank you for using ERP-Simplified!

## **_Citations_**

Delorme A & Makeig S (2004) EEGLAB: an open-source toolbox for analysis of single-trial EEG dynamics, Journal of Neuroscience Methods 134:9-21.

Irene Winkler, Stefan Haufe and Michael Tangermann. Automatic Classification of Artifactual ICA-Components for Artifact Removal in EEG Signals. Behavioral and Brain Functions, 7:30, 2011. 

Irene Winkler, Stephanie Brandl, Franziska Horn, Eric Waldburger, Carsten Allefeld and Michael Tangermann. Robust artifactual independent component classification for BCI practitioners. Journal of Neural Engineering, 11 035013, 2014.

Lopez-Calderon, J., & Luck, S. J. (2014). ERPLAB: An open-source toolbox for the analysis of event-related potentials. Frontiers in human neuroscience, 8, 213.

