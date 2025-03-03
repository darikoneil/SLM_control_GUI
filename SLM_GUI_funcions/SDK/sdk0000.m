classdef sdk0000 < handle
    properties
        varsion = '0000'
        is_OD = 0;

        SLM_SDK_dir = '';
        bit_depth = 12; % 512 is 8, 1920 is 12
        num_boards_found = libpointer('uint32Ptr', 0);
        constructed_okay = libpointer('int32Ptr', 0);
        is_nematic_type = 1;
        RAM_write_enable = 1;
        max_transients = 10; % this is specific to ODP slms (512)
        wait_For_Trigger = 0; % This feature is user-settable; use 1 for 'on' or 0 for 'off'
        external_Pulse = 0; % same as output_pulse_image_flip?
        timeout_ms = 5000;
        flip_immediate = 0;
        output_pulse_image_refresh = 0;
        true_frames = 3;
        use_GPU = 0;    % this is specific to ODP slms (512)

        init_lut_fpath = libpointer('string'); % null for new bns, only important for old
        lut_path = '';

        SDK_created = 0;
        board_number;
        height;
        width;

        val_complete;
    end
    methods
        function ops = sdk0000(SLM_ops)
            if ~isfield(SLM_ops, 'SLM_SDK_dir') || isempty(SLM_ops.SLM_SDK_dir)
                SLM_ops.SLM_SDK_dir = "";
            end
            
            if ~isfield(SLM_ops, 'height')
                SLM_ops.height = 1024;
            end

            if ~isfield(SLM_ops, 'width')
                SLM_ops.width = 1024;
            end
            
            
            if ~isfield(SLM_ops, 'is_OD')
                SLM_ops.is_OD = 0;
            end
            
            if ~isfield(SLM_ops, 'bit_depth')
                SLM_ops.bit_depth  = 12;
            end
            
            if ~isfield(SLM_ops, 'lut_fname')
                SLM_ops.lut_fname = 'linear.lut';
            end

            ops.SLM_SDK_dir = SLM_ops.SLM_SDK_dir;
            
            ops.is_OD = SLM_ops.is_OD;

            if ops.is_OD
                ops.use_GPU = 1;    % this is specific to ODP slms (512) (and imagegen)
            end

            if ops.is_OD
                if ~isfield(ops, 'init_lut_fname') || ~exist([SLM_ops.lut_dir, '\', SLM_ops.init_lut_fname], 'file')   % use linear if not specified
                    error('Overdrive SLM requires regional lut for initialization under "init_lut_fname" param')
                else
                    ops.init_lut_fpath = [SLM_ops.lut_dir, '\', SLM_ops.init_lut_fname];
                end
            else
                ops.lut_path = [SLM_ops.lut_dir '\' SLM_ops.lut_fname];
                if ~exist(ops.lut_path, 'file')
                    error('Lut file "lut_fname" missing from: %s', ops.lut_path);
                end
            end
            
            ops.height = SLM_ops.height;
            ops.width = SLM_ops.width;
            ops.bit_depth = SLM_ops.bit_depth;

        end
        %%
        function obj = init(obj)
            disp("Initializing SLM SDK 0000 (Mock SDK)");
            
            disp("Loading DLL");
            
            %% - create SDK
            
            disp("Creating SDK");
            obj.SDK_created = 1;
            obj.board_number = 1;
            disp('Blink SDK was successfully constructed');
            fprintf('Found %u SLM controller(s)\n', 1);
            obj.height = 1152;
            obj.width = 1920;
            disp("LUT Loaded");

        end

        %%
        function write_image(ops, image_pointer)
            disp("Image written to SLM (NOT OD)");
        end
       
        function write_image_OD(ops, image_pointer)
            disp("Image written to SLM (NOT OD)");
        end
        function image_write_complete(ops)
            % checks if image is complete
            ops.val_complete = 1;
        end
        function load_lut(ops)
            if ops.SDK_created
                fprintf('Uploading lut %s\n', ops.lut_path);
                ops.val_complete = 1;
            end
        end
        function load_linear_lut(ops)
            ops.val_complete = 1;
        end
        
        function close(ops)
            % Always call Delete_SDK before exiting
            if ops.SDK_created;
                disp('Deleted SDK')
                ops.SDK_created = 0;
            end
            
            disp("Freed DLL")
        end
    end
end


