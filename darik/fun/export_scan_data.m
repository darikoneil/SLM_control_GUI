function export_scan_data(location, scan_data)
% Exports xyz data to language-agnostic format

%% Imaging Coordinates
filename = strcat([location, '\', 'Right_half_', scan_data.im_pattern, '.parquet']);
parquetwrite(filename, scan_data.group_table_im);

end

