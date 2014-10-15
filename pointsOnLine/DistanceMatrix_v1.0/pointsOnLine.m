function  points=pointsOnLine(point1,point2,numPoints)
%linearly spaced points between two points in space
%Input coordinate of two point in space and number of points between them
%point1 : 1 x 3 array
%point2 : 1 x 3 array
%numPoints : an integer 
%
%Output coordinates of points be point1 and point2
%points : m x 3 array , m is equal to numPoints

dvec=point2-point1;
spacing=linspace(0,1,numPoints);
points=zeros(numPoints,3);

points(:,1)=point1(1)+spacing.*dvec(1);
points(:,2)=point1(2)+spacing.*dvec(2);
points(:,3)=point1(3)+spacing.*dvec(3);

return