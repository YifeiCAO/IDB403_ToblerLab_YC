% Potential models:
% * Model 001 included both the onsets and whole block regressors (but was found to nto be suitable)
% * Model 002 is similar to model 001 but includes only the onsets (whole block regressors are omitted)
% * Model 003 is similar to model 001 but includes only the whole blocks (onsets regressors are omitted)

% If the bash commands to run bash and python scripts do not run make the
% files executable using 'chmod x+ FileName'

%% Define model to run:
modelToRun = '002';

%% FOLLOWING fMRIprep
% -------------------------------------------------------------------------
%% 0. Make sure fMRIprep ran with NO ERRORS for all the subjects:
verify_fMRIprep_output()

%% 1. Extract the skull from the preprocessed (task) fMRI (using fslmath):
extract_skull_for_preprocessed_functional_images()

%% 2. Create motion confounds and do related QA:
create_motion_confounds_files_after_fmriprep_v2_and_related_qa()

%% 3. Create event.tsv files:
create_event_files()

%% 4. Create onset files (based on the evets.tsv files):
system(['./runBIDSto3col_all_subjects.sh ' modelToRun]) % this files use BIDSto3col.sh. * The argument is the model name.

%% 5. Create the first level fsf files (based on a prepared template) and the launch files to run them: 
create_lev1_fsfs(modelToRun)

%% 6. Execute the launch files to run first level:
SUBJECTS = [106];
run_lev1(SUBJECTS, modelToRun) % The argument must be either 'all' ot a vector of subject numbers.

%%
% Use this if there is a problem with running the launch files:
run_lev1_launch_alternative(SUBJECTS, modelToRun) 
