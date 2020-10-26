close all;
dbstop error;
clear;
addpath(genpath(pwd))
%% 3D point
image_point = importdata('camera_point.mat');
lidar_point = importdata('lidar_point.mat');

%% icp
TF=eye(4);
TF(1:3,1:3)=[0 0 1;-1 0 0;0 -1 0];
TF1=affine3d(TF);
[tform,~] = pcregrigid(pointCloud(lidar_point),pointCloud(image_point'),'InitialTransform',TF1);

%% plot to check the result
T1 = tform.T;
r = T1(1:3,1:3).';
t = T1(4,1:3)'
pc_lidar2im=r*lidar_point'+repmat(t,1,length(lidar_point));
pc_lidar2im=pc_lidar2im';
figure(3);
pcshow(pc_lidar2im);
hold on;%
plot3(image_point(1,:),image_point(2,:),image_point(3,:),'*r');


%% transform matrix
extrinsic = (tform.T).';
A = importdata('data/cameraParams.mat'); %calibration matrix of camera using matlab_camera_calibrator
intrinsic = A.IntrinsicMatrix;
intrinsic = intrinsic';
intrinsic=cat(2,intrinsic,[0;0;0]);
cali = intrinsic * extrinsic;

%% plot
for i=1:23
    img_frame = imread(['data/',num2str(i),'.jpg']);
    ptCloud = pcread(['data/',num2str(i),'.pcd']);
    lidar_frame = ptCloud.Location;
    idx = lidar_frame(:,1)<2;
    lidar_frame(idx,:) = [];
    figure(1);
    imshow(img_frame,'border','tight','InitialMagnification','fit');
    axis normal;
    hold on;
    lidar_img = project(lidar_frame(:,1:3),cali);
    for i=1:size(lidar_img,1)
        plot(lidar_img(i,1),lidar_img(i,2),'o','LineWidth',1,'MarkerSize',1,'Color',[1,0,0]);
    end
    hold off;
end