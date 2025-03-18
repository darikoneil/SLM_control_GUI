function coord_corr = f_sg_coord_correct(reg1, coord)
% correct all except for (0, 0, 0) zero order 
coord_corr = coord;

% REVIEW
% Shouldn't xyz offset ALWAYS be applied, but the transformation index only
% applied to first-order points?
% coord_corr.xyzp(non_zero_idx,:) = (coord.xyzp(non_zero_idx,:)+reg1.xyz_offset)*reg1.xyz_affine_tf_mat;
coord_corr.xyzp = coord_corr.xyzp + reg1.xyz_offset;
if sum(coord.xyzp == 0, 2) < 3
    non_zero_idx = sum(coord.xyzp == 0,2) < 3;
    coord_corr.xyzp = coord_corr.xyzp(non_zero_idx, :) * reg1.xyz_affine_tf_mat;
end
end