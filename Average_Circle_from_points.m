function [Center, Radius,Meanresultantvectorlength] = Average_Circle_from_points(pointset)
    %get rid of outliers in point set
    pointset = rmoutliers(pointset);
    Xvalues = pointset(:,1);
    Yvalues = pointset(:,2);
    [rowsize, columnsize] = size(pointset);
    
    %This calculates your average value of each row
    avg_X = mean(Xvalues);
    avg_Y = mean(Yvalues);
    
    %This puts it in terms of U and V
    Upoints = Xvalues - avg_X;
    Vpoints = Yvalues - avg_Y;
    
    %Suu means the sum of Upoints^2, Su means sum of U points
    Suu = sum(Upoints.^2);
    Svv = sum(Vpoints.^2);
    Suv = sum(Upoints.*Vpoints);
    Suuu = sum(Upoints.^3);
    Suvv = sum((Vpoints.^2).*Upoints);
    Svvv = sum(Vpoints.^3);
    Svuu = sum(Upoints.^2 .* Vpoints);
    
    %solve the systems of equations
    systemofEQ = [Suu , Suv, .5*(Suuu+Suvv); ...
    Suv, Svv , .5*(Svvv + Svuu)];
    Solutions = rref(systemofEQ);
    
    %This gives the center of the circle
    
    CenterinUV = [Solutions(1,3), Solutions(2,3)];
    
    %now convert from UV to XY
    Center = [CenterinUV(1,1) + avg_X, CenterinUV(1,2) + avg_Y];
    
    %now Calculate the radius
    Rsqured = (CenterinUV(1))^2+(CenterinUV(2))^2 + (Suu + Svv)/rowsize;
    Radius = sqrt(Rsqured);



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%
    %This is an attempt to calculate the reliablilty of the circle create and
    %or the accuracy
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    %This creates a vector from the center for the circle to the outer point
    Xcircletopoints = Xvalues - Center(1,1);
    Ycircletopoints = Yvalues - Center(1,2);
    
    %Then we sum all of the vectors to create a total resultant vector
    Xresultant = sum(Xcircletopoints);
    Yresultant = sum(Ycircletopoints);
    
    %Now we calculate the length of the resultant vector
    ResultantLength = sqrt(Xresultant^2 + Yresultant^2);
    
    %UnitresultX = (Xresultant)/ResultantLength + Center(1,1);
    %UnitresultY = (Yresultant)/ResultantLength + Center(1,2);
    
    Meanresultantvectorlength = (ResultantLength/length(Upoints))%/Radius;
        
    
end
