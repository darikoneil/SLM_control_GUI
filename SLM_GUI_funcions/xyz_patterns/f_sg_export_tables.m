function f_sg_export_tables(app)
% f_sg_export_tables Exports XYZ data to a language-agnostic tabular format (parquet).
%
%   f_sg_export_tables(app) exports the XYZ data contained in the `app` object
%   to Parquet files. The files are saved in the directory specified by the
%   `save_patterns_dir` property of the `SLM_ops` object within `app`.
%
%   Inputs:
%       app - An object containing the following properties:
%           SLM_ops.save_patterns_dir - A string specifying the directory where the files will be saved.
%           xyz_patterns - A structure array containing the following fields:
%               pat_name  - A string specifying the pattern name.
%               SLM_region - A string specifying the SLM region name.
%               xyz_pts   - A table containing the XYZ coordinates.
%
%   Example:
%       app.SLM_ops.save_patterns_dir = 'C:\data';
%       app.xyz_patterns(1).pat_name = 'PatternA';
%       app.xyz_patterns(1).SLM_region = 'Region1';
%       app.xyz_patterns(1).xyz_pts = table([1; 2; 3], [4; 5; 6], [7; 8; 9], ...
%                                           'VariableNames', {'X', 'Y', 'Z'});
%       f_sg_export_tables(app);
    save_location = app.SLM_ops.save_patterns_dir;
    xyz_patterns = app.xyz_patterns;
    num_patterns_groups = size(xyz_patterns, 2);
    for i = 1:num_patterns_groups
        pat = xyz_patterns(i);
        name = pat.pat_name;
        region = pat.SLM_region;
        coords = pat.xyz_pts;
        filename = strcat([save_location, '\', replace(region, ' ', '_'), '_', replace(name, ' ', '_'), '.parquet']);
        parquetwrite(filename, coords);
    end

end