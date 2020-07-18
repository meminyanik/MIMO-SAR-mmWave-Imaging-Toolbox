%% Copyright(C) 2018 The University of Texas at Dallas
%  Developed By: Muhammet Emin Yanik
%  Advisor: Prof. Murat Torlak
%  Department of Electrical and Computer Engineering

%  This work was supported by the Semiconductor Research Corporation (SRC) task 2712.029
%  through The University of Texas at Dallas' Texas Analog Center of Excellence (TxACE).

%  Redistributions and use of source must retain the above copyright notice
%  Redistributions in binary form must reproduce the above copyright notice
%%

function ptCloud = convert3DImageToPointCloud(sarImage3D, xRangeT_mm, yRangeT_mm, zRangeT_mm, dynamicRange_dB)
%% Inout format 
% sarImage3D: M_y by M_x by M_z real matrix
% xRangeT_mm: 1 by M_x vector
% yRangeT_mm: 1 by M_y vector
% zRangeT_mm: 1 by M_z vector
% dynamicRange_dB: < 0 in dB

%% Calculate (M_x * M_y * M_z) by 3 location matrix 
[X,Y,Z] = meshgrid(xRangeT_mm,yRangeT_mm,zRangeT_mm);
location = single([X(:) Y(:) Z(:)]);

%% Calculate (M_x * M_y * M_z) by 1 intensity vector 
intensity = reshape(sarImage3D,[],1);


%% Crop the image based on Dynamic Range
intensity_dB = mag2db(intensity/max(intensity));

locationIndex = find(intensity_dB > dynamicRange_dB);
intensity_dB = intensity_dB(intensity_dB > dynamicRange_dB);
location = location(locationIndex,:);

%% create point cloud
ptCloud = pointCloud(location,'Intensity',intensity_dB);

%% Show point cloud
pcshow(ptCloud)

%% (Optional) - Remove noise
% ptCloud = pcdenoise(ptCloud);