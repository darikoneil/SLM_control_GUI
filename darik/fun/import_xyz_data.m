function [xyz_data] = import_xyz_data(file)
    xyz_data = parquetread(file);
end

