%Kaleb Nails
%Created: 3/~/2022
%Modified: 10/25/2022
%Purpose: put a dot on live video feed where the most change in pixels happen

clear, clc,close;
load('cameraParams.mat')
cam = webcam('Integrated Webcam');

oldpic = snapshot(cam);
oldGreyscaled = rgb2gray(oldpic);
oldUndistorted = undistortImage(oldGreyscaled, cameraParams);

pause(.1)



for timer = 1:100

rowlocations = 0;
columnlocations = 0;

newimg = snapshot(cam);
Greyscaled = rgb2gray(newimg);
Undistorted = undistortImage(Greyscaled, cameraParams);

%[rowlocations, columnlocations] = find(0== Undistorted - oldUndistorted );
difpoints = abs(Undistorted - oldUndistorted);

[rowlocations, columnlocations] = find(110>difpoints & difpoints>70);




axis equal
axis tight
%compare = [Undistorted, oldUndistorted];


%imshow(compare);
imshow(Undistorted)

hold on
plot(round(mean(columnlocations)),round(mean(rowlocations)),'r*','MarkerSize',16);
oldUndistorted = Undistorted;






pause(.1)
end
hold on
%plot(rowlocations,columnlocations,'b*','MarkerSize',1);

%{
for r = 1:50:length(columnlocations)
plot(columnlocations(r,1),rowlocations(r,1),'b*','MarkerSize',2);
hold on

end
%}
