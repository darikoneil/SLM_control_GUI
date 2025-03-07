function ops = f_darik_slm_ops()

is_final = true;

ops = struct;
ops.SLM_type = 'BNS1920'; 
ops.imageGen_ver = '4857';
ops.imageGen_dir = 'C:\Program Files\Meadowlark Optics\Blink_SDK_all\SDK_1920_4_857';       % newer version
ops.GS_z_factor = 50/39.7;  % scaling factor for meadowlark GS defocus to match effNA
ops.GS_num_iterations = 100; % number of iterations for meadowlark GS optimization

%% SLM specific params
%idx = 1;
%SLM_params(idx).SLM_name = 'BNS1920';
%SLM_params(idx).is_OD = 0;
%SLM_params(idx).SDK_ver = '4857'; % 4857, 4851
%SLM_params(idx).bit_depth = 12;
%SLM_params(idx).height = 1152;
%SLM_params(idx).width = 1920;
%SLM_params(idx).lut_fname = 'linear_cut_940_1064.lut'; % linear_cut_940_1064.lut
%SLM_params(idx).SLM_SDK_dir = 'C:\Program Files\Meadowlark Optics\Blink_SDK_all\SDK_1920_4_857'; % Blink OverDrive Plus\SDK, SDK_1920_4_857, SDK_1920_3_528
%SLM_params(idx).regions_use = {'Right half', 'Left half', 'Full SLM'};


idx = 1;
SLM_params(idx).SLM_name = 'BNS1920';
SLM_params(idx).is_OD = 0;
SLM_params(idx).SDK_ver = '4857'; % 0000, 4857, 4851
SLM_params(idx).bit_depth = 12;
SLM_params(idx).height = 1152;
SLM_params(idx).width = 1920;
SLM_params(idx).lut_fname = 'linear_cut_940_1064.lut'; % linear_cut_940_1064.lut
SLM_params(idx).SLM_SDK_dir = 'C:\Program Files\Meadowlark Optics\Blink_SDK_all\SDK_1920_4_857'; % Blink OverDrive Plus\SDK, SDK_1920_4_857, SDK_1920_3_528
SLM_params(idx).regions_use = {'Right half', 'Left half', 'Full SLM'};


%% some default general params

% determines the size of all radial patterns (defocus and zernike)
ops.objective_RI = 1.33;    % used in defocus functions
ops.tube_length = 0.180;     % meters
ops.zoom = 1.2;
ops.NI_DAQ_dvice = 'dev2';
ops.NI_DAQ_counter_channel = 0;
ops.NI_DAQ_AI_channel = 0;
ops.NI_DAQ_AO_channel = 0;
ops.orbital_mag = 0;

%% objective list
idx = 1;
objectives(idx).obj_name = '25X_long';
objectives(idx).FOV_size = 495;
objectives(idx).magnification = 25;
objectives(idx).orbital = 0;

idx = idx + 1;
objectives(idx).obj_name = '25X_fat';
objectives(idx).FOV_size = 497; % w orb 511; no orb 497
objectives(idx).magnification = 25;
objectives(idx).orbital = 1;

%% 25x Long with BNS1920
idx = 1;
region_params(idx).obj_name = '25X_long';
region_params(idx).SLM_name = 'BNS1920';
region_params(idx).reg_name = 'Right half';
region_params(idx).wavelength = 920;
region_params(idx).phase_diameter = 1152;
region_params(idx).zero_outside_phase_diameter = true;
region_params(idx).beam_diameter = 1152;
region_params(idx).effective_NA = 0.628;
region_params(idx).lut_correction_fname = 'photodiode_lut_920nm_coherent_225pv_1kterm_pin_det10A_64r_128r_01_26_25_01h_16m_corr_more_smooth_sub_region_interp_corr.mat';
region_params(idx).xyz_affine_tf_fname = 'xyz_calib_1_27_25_18h_42m.mat';
region_params(idx).AO_correction_fname =  'AO_correction_25x_maitai_5_19_23.mat';
region_params(idx).point_weight_correction_fname = [];
region_params(idx).xyz_offset = [0 0 0]; % baseline beam offset
region_params(idx).xy_over_z_offset = [-0.028 -0.01]; % no orb w na corr [-0.014 0.012]%no orb [-0.02 0.006]; worb[0.027 -0.012]; % axial beam offset by z
region_params(idx).zero_order_supp_phase = 5.51935; % in radians % 224 from [0 - 255]
region_params(idx).zero_order_supp_w = 0.26;
region_params(idx).beam_dump_xy = [-350, 0];

idx = idx + 1;
region_params(idx).obj_name = '25X_long';
region_params(idx).SLM_name = 'BNS1920';
region_params(idx).reg_name = 'Left half';
region_params(idx).wavelength = 1064;
region_params(idx).phase_diameter = 1152;
region_params(idx).zero_outside_phase_diameter = true;
region_params(idx).beam_diameter = 1152;
region_params(idx).effective_NA = 0.565; % 0.565 from 11/11/21% 0.51 before
region_params(idx).lut_correction_fname = 'photodiode_lut_1064_slm5221_4_7_22_left_half_corr2_sub_region_interp_corr.mat';
region_params(idx).xyz_affine_tf_fname = 'xyz_calib_25x_fianium_11_11_21.mat';
region_params(idx).AO_correction_fname = [];
region_params(idx).point_weight_correction_fname = 'Fianium_0z_4_10_22_pw_corr.mat';
region_params(idx).xyz_offset = [0 0 -6];  % baseline beam offset
region_params(idx).xy_over_z_offset = [-0.018 0.0095]; % axial beam offset by z
region_params(idx).zero_order_supp_phase = 0; % in radians % 224 from [0 - 255] 
region_params(idx).zero_order_supp_w = 0;
region_params(idx).beam_dump_xy = [-350, 0];

%% 25x with BNS1920
idx = idx + 1;
region_params(idx).obj_name = '25X_fat';
region_params(idx).SLM_name = 'BNS1920';
region_params(idx).reg_name = 'Right half';
region_params(idx).wavelength = 940;
region_params(idx).phase_diameter = 1152;
region_params(idx).zero_outside_phase_diameter = true;
region_params(idx).beam_diameter = 1152;
region_params(idx).effective_NA = 0.632; %.632 no compensation 5/28/23 %0.615 5/8 new ao; 0.625; % 0.625 no orb with na corr; 0.632; % 0.635 on p2obj; no orb 0.632;  w orb 0.61; no orb 0.632 % 11/11/21 0.62  before 11/11/21 0.605;
region_params(idx).lut_correction_fname = 'photodiode_lut_940_slm5221_4_7_22_right_half_corr2_sub_region_interp_corr.mat';
region_params(idx).xyz_affine_tf_fname = 'xyz_calib_25x_maitai_11_11_21.mat';
region_params(idx).AO_correction_fname =  'AO_correction_25x_maitai_5_19_23.mat'; %'AO_correction_25x_maitai_4_16_23.mat'; % 'AO_correction_25x_maitai_11_21_21.mat';
region_params(idx).point_weight_correction_fname = [];
region_params(idx).xyz_offset = [0 0 0]; % baseline beam offset
region_params(idx).xy_over_z_offset = [-0.028 -0.01]; % no orb w na corr [-0.014 0.012]%no orb [-0.02 0.006]; worb[0.027 -0.012]; % axial beam offset by z
region_params(idx).zero_order_supp_phase = 5.51935; % in radians % 224 from [0 - 255]
region_params(idx).zero_order_supp_w = 0.26;
region_params(idx).beam_dump_xy = [-350, 0];

idx = idx + 1;
region_params(idx).obj_name = '25X_fat';
region_params(idx).SLM_name = 'BNS1920';
region_params(idx).reg_name = 'Left half';
region_params(idx).wavelength = 1064;
region_params(idx).phase_diameter = 1152;
region_params(idx).zero_outside_phase_diameter = true;
region_params(idx).beam_diameter = 1152;
region_params(idx).effective_NA = 0.565; % 0.565 from 11/11/21% 0.51 before
region_params(idx).lut_correction_fname = 'photodiode_lut_1064_slm5221_4_7_22_left_half_corr2_sub_region_interp_corr.mat';
region_params(idx).xyz_affine_tf_fname = 'xyz_calib_25x_fianium_11_11_21.mat';
region_params(idx).AO_correction_fname = [];
region_params(idx).point_weight_correction_fname = 'Fianium_0z_4_10_22_pw_corr.mat';
region_params(idx).xyz_offset = [0 0 -6];  % baseline beam offset
region_params(idx).xy_over_z_offset = [-0.018 0.0095]; % axial beam offset by z
region_params(idx).zero_order_supp_phase = 0; % in radians % 224 from [0 - 255] 
region_params(idx).zero_order_supp_w = 0;
region_params(idx).beam_dump_xy = [-350, 0];


%% default directories
%ops.GUI_dir = 'C:\Users\rylab_901c_slm\PycharmProjects\split_slm\slm_legacy\SLM_GUI\SLM_GUI';
ops.GUI_dir = pwd();%'C:\Users\rylab_901c_slm\PycharmProjects\SLM_control_GUI';
darik_dir = '\darik\';
if exist('is_final', 'var')
    ops.calibration_dir = [ops.GUI_dir darik_dir 'calibrations\final'];
else
    ops.calibration_dir = [ops.GUI_dir darik_dir 'calibrations'];
end
ops.save_dir = [ops.GUI_dir darik_dir 'outputs'];
ops.lut_dir = [ops.calibration_dir '\luts'];
for par = 1:numel(SLM_params)
    SLM_params(par).lut_dir = ops.lut_dir;
end
ops.xyz_calibration_dir = [ops.calibration_dir '\xyz'];
ops.AO_correction_dir = [ops.calibration_dir '\ao'];
ops.point_weight_correction_dir = [ops.calibration_dir '\point_weight'];

ops.custom_phase_dir = [ops.calibration_dir '\custom'];
ops.pattern_editor_dir = [ops.calibration_dir '\patterns'];

ops.save_AO_dir = [ops.save_dir '\AO_outputs'];
ops.save_patterns_dir = [ops.save_dir '\saved_patterns'];
ops.save_lut_dir = [ops.save_dir '\lut_calibration'];

% directory from microscope computer where frames are saved during AO optimization
ops.AO_recording_dir = '';

%% defauld regions list
idx = 1;
region_list(idx).reg_name = 'Right half';
region_list(idx).height_range = [0, 1];
region_list(idx).width_range = [0.5, 1];

idx = idx + 1;
region_list(idx).reg_name = 'Left half';
region_list(idx).height_range = [0, 1];
region_list(idx).width_range = [0, 0.5];

idx = idx + 1;
region_list(idx).reg_name = 'Full SLM';
region_list(idx).height_range = [0, 1];
region_list(idx).width_range = [0, 1];


%% default xyz pattern - regions
% xyz_pts formats: [x y z]; [x y z weight]; [pat x y z weight]
idx = 1;
xyz_patterns(idx).pat_name = 'Darik Imaging';
xyz_patterns(idx).xyz_pts = [10 0 -25;...
                             0 10 0;...
                             10 0 25;...
                             ];
xyz_patterns(idx).SLM_region = 'Right half';

idx = idx + 1;
xyz_patterns(idx).pat_name = 'Darik Stim';
xyz_patterns(idx).xyz_pts = [1 25 0 -25 1;...
                             1 0 25 -25 1;...
                             2 25 0 0 1;...
                             2 0 25 0 1;...
                             3 25 0 0 1;...
                             3 0 25 0 1;...
                             ];
xyz_patterns(idx).SLM_region = 'Left half';

%% 
pw_calibration.smooth_std = 1;
pw_calibration.min_thresh = 0.3;
pw_calibration.pw_sqrt = 1;

%% ao default params

AO_params.min_Zn = 0;
AO_params.max_Zn = 5;
AO_params.w_range = 1.5;
AO_params.num_w_steps = 13;
AO_params.w_spline_sm_param = 0.5;
AO_params.w_reg_factor = 0.003;
AO_params.ignore_spherical = 1;
AO_params.scans_per_mode = 4;
AO_params.default_AO_scan_path = '\\PRAIRIE2000\p2f\Yuriy\SLM\PSF\AO_optimization-001';
AO_params.Optimization_method = 'Sequential';
AO_params.refocus_every_n_frames = 200;
AO_params.refocus_dist = 10;
AO_params.refocus_num_steps = 11;
AO_params.refocus_spline_sm_param = 0.3;
AO_params.scan_all_corr_every_n_frames = 500;
AO_params.decrease_grad_n_times = 0;
AO_params.num_iterations = 100;
AO_params.bead_win_size = 80;
AO_params.post_scan_delay = 0.8;
AO_params.fit_ao_method = 'linearinterp'; % linearinterp, smoothingspline
AO_params.fit_spline_sm_param = 0.5;
AO_params.fit_save_weights = 1;
AO_params.constrain_z0 = 0;
AO_params.compensate_z = 1;
AO_params.z_comp_thresh = 190; % in um
AO_params.ignore_0 = 0;
AO_params.plot_fit = 1;
AO_params.plot_extra = 0;
AO_params.ignore_all_spherical = 0;

%% save stuff
ops.objectives = objectives;
ops.SLM_params = SLM_params;
ops.region_params = region_params;
ops.region_list = region_list;
ops.xyz_patterns = xyz_patterns;
ops.pw_calibration = pw_calibration;
ops.AO_params = AO_params;

end