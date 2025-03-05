function f_sg_import_tables(app)
%F_SG_IMPORT_TABLES Summary of this function goes here
%   Detailed explanation goes here

    [file, location, ~] = uigetfile('*.parquet', 'Select Tables to Load', app.SLM_ops.save_patterns_dir, 'MultiSelect', 'on');
    num_tables = length(file);
    filepaths = cell(1, num_tables);
    for n = 1:num_tables
        filepaths{n} = fullfile(location, file{n});
    end
    xyz_patterns = app.xyz_patterns;
    for i = 1:num_tables
        coords = parquetread(filepaths{i});
        parts = split(file{i}, '_');
        name = split(parts{end}, '.');
        name = name{1};
        slm_region = split(file{i}, strcat(['_', name, '.parquet']));
        slm_region = slm_region{1};
        slm_region = replace(slm_region, '_', ' ');
        pattern = struct();
        pattern.pat_name = name;
        pattern.xyz_pts = coords;
        pattern.SLM_region = slm_region;
        xyz_patterns = [xyz_patterns, pattern];
    end
    
    app.xyz_patterns = xyz_patterns;
    app.PatterngroupDropDown.Items = {app.xyz_patterns.pat_name}; 
    app.PatternDropDownCtr.Items = [{'None'}, app.xyz_patterns.pat_name];
    app.PatternDropDownAI.Items = [{'None'}, app.xyz_patterns.pat_name];

end

