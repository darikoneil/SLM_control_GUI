function f_sg_lc_click_points_all_lateral(app)

data1 = app.data.lat_calib_all;

islateral = app.UITable.Data(:,4).Variables;

num_im = size(data1,1);

if app.StableZeroOrderCheckBox.Value
    stable_zero = true;
    needs_zero_set = true;
else
    stable_zero = false;
    needs_zero_set = true;
end
    
zero_ord_coords = zeros(num_im,2);
first_ord_coords = zeros(num_im,2);
figure;
for n_file = 1:num_im
    if islateral(n_file)
        imagesc(data1(n_file).image);
        colormap(colorcet('L8'));
        axis tight equal;
        title(sprintf('X=%d Y=%d Z=%d, click on zero order spot', data1(n_file).X, data1(n_file).Y, data1(n_file).Z));
        if needs_zero_set
            if stable_zero
                [x1, y1] = ginput(1);
                zero_ord_coords(n_file,:) = [x1, y1];
                for n = 1:num_im
                    zero_ord_coords(n, :) = [x1, y1];
                end
                needs_zero_set=false;
            else
                [x1, y1] = ginput(1);
                zero_ord_coords(n_file,:) = [x1, y1];
            end
        end
        title(sprintf('X=%d Y=%d Z=%d, click on first order spot', data1(n_file).X, data1(n_file).Y, data1(n_file).Z));
        [x1, y1] = ginput(1);
        first_ord_coords(n_file,:) = [x1, y1];
    end
end
close;

app.data.zero_ord_coords = zero_ord_coords;
app.data.first_ord_coords = first_ord_coords;

end