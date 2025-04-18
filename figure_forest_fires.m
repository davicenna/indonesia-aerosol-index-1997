% Path to your NetCDF file
filename = '/Users/dataavicenna/Documents/MATLAB/g4.timeAvgMap.TOMSEPL3_008_Aerosol.19970801-19971130.180W_90S_180E_90N.nc';

% Load lat/lon and aerosol data
info = ncinfo(filename);
lat = ncread(filename, 'lat');
lon = ncread(filename, 'lon');
aerosol = ncread(filename, info.Variables(1).Name);

% Define Indonesia bounds
lat_bounds = [-11 6];
lon_bounds = [95 141];

% Find indices for bounding box
lat_idx = find(lat >= lat_bounds(1) & lat <= lat_bounds(2));
lon_idx = find(lon >= lon_bounds(1) & lon <= lon_bounds(2));

% Subset lat/lon and data
indonesia_lat = lat(lat_idx);
indonesia_lon = lon(lon_idx);
if size(aerosol,1) == length(lon)
    aerosol_subset = aerosol(lon_idx, lat_idx);
else
    aerosol_subset = aerosol(lat_idx, lon_idx)';
end

% Create grid
[LON, LAT] = meshgrid(indonesia_lon, indonesia_lat);

% Plot with worldmap and coastlines
figure;
worldmap(lat_bounds, lon_bounds);
surfm(LAT, LON, aerosol_subset');

% Add coastlines to make Indonesia visible
load coastlines
geoshow(coastlat, coastlon, 'Color', 'k', 'LineWidth', 1.2);

% Color and title
colorbar;
colormap(jet);
title('TOMS Aerosol Index over Indonesia (Aug-Nov 1997 Average)');
