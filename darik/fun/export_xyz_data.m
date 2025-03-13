function export_xyz_data(location, XYZ_data)
% Exports xyz data to language-agnostic format

%% Imaging Coordinates
filename = strcat([location, '\', replace(XYZ_data.region, ' ', '_'), '_', replace(XYZ_data.pattern, ' ', '_'), '.parquet']);
parquetwrite(filename, XYZ_data.coords_table);
end

