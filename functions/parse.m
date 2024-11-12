% parse - Reads data from an HDF5 file and organizes it into a structured format.
% 
% This function reads datasets from an HDF5 file and stores them in a MATLAB
% structure. If the optional argument `check_fields_on_all_chunks` is provided,
% it checks whether the datasets have been already read and appends the
% data accordingly. This argument allows you to read chunked data that may
% not have all fields in all chunks (as data may exist at certain times but 
% not others in the underlying logs). however, it will slow parsing down
% 
% Syntax:
%   data_struct = parse(filename)
%   data_struct = parse(filename, check_fields_on_all_chunks)
%
% Inputs:
%   filename (string) - Path to the HDF5 file to read data from.
%   check_fields_on_all_chunks (logical, optional) - If true, checks if fields
%     already exist in the structure before appending new data. Default is false.
%
% Outputs:
%   data_struct (struct) - A structure containing the datasets from the HDF5 file.
%     Each field corresponds to a dataset, with the dataset name as the field name
%     and the data stored as the field value.
%
% Example:
%   data = parse('data.h5');  % Reads the data from 'data.h5' into a structure.
%   data = parse('data.h5', true);  % Checks if fields exist and appends data.
%
% Notes:
%   - The function assumes that the HDF5 file consists of groups containing datasets.
%   - The datasets are appended to existing fields in the structure when `i > 1`.
%   - The datasets' names are used as the field names in the output structure.
%
% See also: h5info, h5read, setfld, getfld

function [data_struct] = parse(filename, check_fields_on_all_chunks)
    % Default value for checking fields
    do_check = false;
    
    % Check if the optional argument is provided
    if nargin > 1
        do_check = check_fields_on_all_chunks;
    end

    % Start timer for execution time tracking
    tic
    
    % Get information about the HDF5 file
    info = h5info(filename);
    
    % Initialize the output structure
    data_struct = struct();
    
    % Iterate through the groups in the HDF5 file
    for i = (1:length(info.Groups.Groups))
        dataset_len = length(info.Groups.Groups(i).Datasets);
        
        % Iterate through the datasets in each group
        for j = (1:dataset_len)
            % Get the name of the dataset
            data_field_name = info.Groups.Groups(i).Datasets(j).Name;
            
            % Read the dataset data
            data = h5read(filename, info.Groups.Groups(i).Name+"/"+data_field_name);
            
            % If not the first group, check if data needs to be appended
            if(i > 1)
                if(do_check)
                    % If checking, append data to existing field if it exists
                    if(anyisfield(data_struct, data_field_name))
                        data = [getfld(data_struct, data_field_name).' data];
                    end
                else
                    % Append data to the existing field unconditionally
                    data = [getfld(data_struct, data_field_name).' data];
                end
            end
            
            % Set the data in the structure
            data_struct = setfld(data_struct, data_field_name, data.');
        end
    end
    
    % End timer and display elapsed time
    toc
end
