clear, clc,close;
load('cameraParams.mat')
cam = webcam('Integrated Webcam');

%This takes the first picture to compare to
oldpic = snapshot(cam);
oldGreyscaled = rgb2gray(oldpic);
oldUndistorted = undistortImage(oldGreyscaled, cameraParams);
[Pxlength, pxheight] = size(oldUndistorted);

pause(.1)



for timer = 1:200

    %resets row and column locations per picture since we don't need to 
    %record all of the pixels that changed over time
    rowlocations = 0;
    columnlocations = 0;
    
    %Takes a new picture and grey scales it
    newimg = snapshot(cam);
    Greyscaled = rgb2gray(newimg);
    Undistorted = undistortImage(Greyscaled, cameraParams);
    
    %calculates the difference in grey scale value between the new and old
    %picture
    difpoints = abs(Undistorted - oldUndistorted);
    
    %finds where the changes are above a certain magnitude
    [rowlocations, columnlocations] = find(110>difpoints & difpoints>70);
    
    %This is used to detect circles in the image
  
    pointset = [rowlocations, columnlocations];
    [Center, Radius, Meanresultantvectorlength] = Average_Circle_from_points(pointset);
   
    

    axis([0 1280 0 720])
    imshow(Undistorted)
    X_pixel_movement = round(mean(columnlocations));
    Y_pixel_movement = round(mean(rowlocations));
    Average_movement = [X_pixel_movement, Y_pixel_movement];
    
    hold on
    plot(round(mean(columnlocations)),round(mean(rowlocations)),'r*','MarkerSize',16);
    oldUndistorted = Undistorted;
    distance = sqrt((Average_movement(1,1)-Center(1,1))^2 + (Average_movement(1,1)-Center(1,1))^2);

    if distance < pxheight/40 & Meanresultantvectorlength < 30
        hold on
        plot(Center(1,1),Center(1,2),'b*','MarkerSize',13)
        hold on
        viscircles(Center,Radius,'color','b')
    end
    
    
    pause(.1)
end

