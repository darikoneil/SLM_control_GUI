function f_sg_import_tables(app)
%F_SG_IMPORT_TABLES Summary of this function goes here
%   Detailed explanation goes here
    [file, location, ~] = uigetfile('*.parquet', 'Select Tables to Load', app.SLM_ops.save_patterns_dir, 'MultiSelect', 'on');
    if iscell(file)
        num_tables = length(file);
        filepaths = cell(1, num_tables);
        for n = 1:num_tables
            filepaths{n} = fullfile(location, file{n});
        end
    else
        num_tables = 1;
        filepaths = cell(1, 1);
        filepaths{1} = fullfile(location, file);
    end
    
    for i = 1:num_tables
        coords = parquetread(filepaths{i});
        true_file = split(filepaths{i}, '/');
        true_file = true_file{end};
        parts = split(true_file, '_');
        name = split(parts{end}, '.');
        name = name{1};
        
        relative_file = split(true_file, '\');
        slm_region = split(relative_file{end}, '.');
        slm_region = slm_region{1};
        slm_region = split(slm_region, '_');
        slm_region = strcat([slm_region{1}, ' ', slm_region{2}]);
        
        pattern = struct();
        pattern.pat_name = name;
        pattern.xyz_pts = coords;
        pattern.SLM_region = slm_region;
        
        app.xyz_patterns = [app.xyz_patterns, pattern];
        app.PatterngroupDropDown.Items = {app.xyz_patterns.pat_name}; 
        app.CurrentregionDropDown.Value = pattern.SLM_region;
        app.UIImagePhaseTable.Data = pattern.xyz_pts;
        app.PatternDropDownCtr.Items = [{'None'}, app.xyz_patterns.pat_name];
        app.PatternDropDownAI.Items = [{'None'}, app.xyz_patterns.pat_name];
        app.PatternDropDownCtr.Value = pattern.pat_name;
        app.PatternDropDownAI.Value = pattern.pat_name;
    end

end

