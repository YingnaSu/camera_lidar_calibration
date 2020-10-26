%% checkerboard points in the camera coordinate
function points_camera=points_from_camera()
A = importdata('data/cameraParams.mat'); %calibration matrix of camera using matlab_camera_calibrator
R = A.RotationMatrices;
T = A.TranslationVectors/1000;

points_camera = [];
p1=importdata('data/checker.mat'); %3d coordinates of checkerboard corners in the camera coordinate system
table=1:3:23;
for i = 1:23
    if ismember(i,table)
        points_camera = [points_camera R(:,:,i).'*p1+T(i,:).'];
    end
end

save('camera_point.mat','points_camera');  
