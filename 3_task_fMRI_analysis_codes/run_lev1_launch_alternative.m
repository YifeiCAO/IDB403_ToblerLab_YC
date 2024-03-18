function run_lev1_launch_alternative(subjects, model)

% Created by Rani Gera, February 2020.
%
% I MADE THIS ALTERNATIVE TO OVERCOME A PROBLEM WITH RUNNING THE LAUNCH FILES.
%
% Arguments:
% subjects - is a vector of subject numbers.
% model - default is 001

%% Parameters:
% ------------------------------
launchdir   = '/Users/yifei/Desktop/A_ETH_UZH/EEG_Cav/Code_EEG/MultiModalMRI_Habits/3_task_fMRI_analysis_codes/launchfiles'; % The directory where it puts all the launch files
if nargin < 2
    model = '001';
end
prefix = ['first_model' model];

%% input check:
% ------------------------------
if nargin < 1
    error('The function requires one input argument: a vector of subject numbers')
end

%% runnning the launch.txt files
% ------------------------------
disp('** Sending THE ALTERNATIVE TO the requested first level launch files for execution:')
if ischar(subjects) && strcmp(subjects,'all')
    error('this function is not suitable to run all together')
elseif isnumeric(subjects)
    for sub = subjects
        file = dir(fullfile(launchdir,[prefix '_sub-' num2str(sub) '_launch.txt']));
        file = {file.name};
        
        fid = fopen(fullfile(launchdir, file{:}));
        tline = fgetl(fid);
        fullLine = [tline ' &'];
        while ischar(tline)
            disp(['-- Execute: ' fullLine])
            system(fullLine)
            tline = fgetl(fid);
            fullLine = [tline ' &'];
        end
        fclose(fid);
    end    
end
disp('** Sending THE ALTERNATIVE TO the requested first level launch files for execution COMPLETED')

end
