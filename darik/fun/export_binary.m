function export_binary(location, name, data)
%EXPORT_BINARY Save data to flat float64
    filename = strcat([name, '_', num2str(size(data, 1)), '_',  num2str(size(data, 2)), '.binary']);
    filepath = fullfile(location, filename);
    file = fopen(filepath, 'wb');
    fwrite(file, data, 'double');
    fclose(file);
end

