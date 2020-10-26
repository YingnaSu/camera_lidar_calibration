%% checkerboard from the lidar data, points fusion of multiple views
function points_lidar=points_from_lidar()

points_lidar=[];
table=1:3:23;
for i=1:23
    if ismember(i,table)
        lidarname=[num2str(i),'.pcd'];
        ptCloud = pcread(['data/',lidarname]);
        velo = ptCloud.Location;
        
        idx = velo(:,1)<2;
        velo(idx,:) = [];
        idx = velo(:,1)>20;
        velo(idx,:) = [];
        idx = velo(:,2)<-3;
        velo(idx,:) = [];
        idx = velo(:,2)>4;
        velo(idx,:) = [];
        idx = velo(:,3)<-0.7;
        velo(idx,:) = [];
        
        ptCloud = pointCloud(velo);
        %figure(1);pcshow(ptCloud);
        
        maxDistance = 0.04;
        referenceVector = [0,0,1];
        maxAngularDistance = 30;
        tmp=1;
        while tmp
            [model,inlierIndices,outlierIndices] = pcfitplane(ptCloud,maxDistance);
            n=model.Normal;
            deg=acosd(dot(n,referenceVector)/norm(n,2)/norm(referenceVector,2));
            if deg>90
                deg=180-deg;
            end
            if deg>maxAngularDistance
                tmp=0;
            else
                ptCloud = select(ptCloud,outlierIndices);
            end
        end
        plane=select(ptCloud,inlierIndices);
        figure(2);pcshow(plane);
        
        velo=plane.Location;
        points_lidar=[points_lidar;velo];
    end
end

save('lidar_point.mat','points_lidar');