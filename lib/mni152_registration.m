%% Clear and close all
clear;
close all;
clc;

% Set params
dataset_folder = '/home/jullygh/sssilvar/Documents/Dataset/FreeSurferSD';

% Process folder
system(['SUBJECTS_DIR=', dataset_folder])

% Start pool
pool = parpool('local');

sub_folders = dir(dataset_folder);

for i = 1:numel(sub_folders)
    subject = sub_folders(i).name;
    
    if ~any(strfind(subject, '.')) && ~any(strfind(subject, 'fsaverage'))
        fprintf('[  OK  ] Processing subject %s\n', subject)
        
        cmd = ['mri_cvs_register --mov ', subject,' --mni --openmp 8'];
        system(cmd)
    end
end

% Close pool
delete(pool)