function [inHullPoints,inPointsIndex]=inConvHull(vert,face,testPoints)
%
%[inHullPoints]=inConvHull(vert,face,testPoints)
%funtion to test whether given points are inside a 3d convex hull or not.
%Algorithm:The algorithm that I have used here is not a standard one.
%          This is analogus to a 2d point in polygon test from 
%          Paul Bourke's website http://paulbourke.net/geometry/insidepoly/
%          The 2d algorithm test a point by checking that it is lying on
%          the right hand side of each edge or not.
%              This can be extended further in 3d.If a point is on the
%          front side of each face of convex hull then the point is 
%          inside the hull otherwise outside.The algorithm uses normal
%          form of plane equation to test a point.
%              Steps included in this algorithm:
%          1-Calculate normal to each face of convex hull..Direction of
%            normal must be towards inside.
%          2-Calculate coefficents A,B,C,D for equation of plane for
%            each face(equation of plane Ax+By+Cz+D=0, where A,B,C are 
%            unit normals). 
%          3-Put x,y and z coordinate of points to be tested in this 
%            equation Ax+By+Cz+D.If the value is positive then the
%            point is on the front side of plane.If it is negative 
%            then the point is on back side of face.If it is zero
%            then the point is on the face.
%
%          A,B,C,D are array so the result of equation is also an array.
%          We have to check whether each element of result is positive or
%          not.This code check for zero and positive value so the output
%          conatins points in the convexHull and on the surface of 
%          hull convex.
%Input:-
%vert : m-by-3 array containing vertices of convex hull 
%face : n-by-3 array conatining indices of vert array that
%       makes faces of convex hull
%testPoints : k-by-3 array containing points to be tested
%
%Output:-
%inHullPoints : p-by-3 array of points inside hull 
%inPointsIndex: 1d array of index such that 
%               inHullPoints=testPoints(inPointsIndex,:);

if nargin<3
   error('Not enough input arguments');
end

if size(vert,2)~=3
   error('vert must be an m-by-3 array.');
end
if size(face,2)~=3
   error('face must be an n-by-3 array.');
end
if size(testPoints,2)~=3
   error('face must be an k-by-3 array.');
end


%vector 
cp1=vert(face(:,1),:)-vert(face(:,2),:);
cp2=vert(face(:,1),:)-vert(face(:,3),:);

%face normals of each face of the convex hull
fNormal=cross(cp1,cp2);

p2=vert(face(:,1),:);
 
denom=sqrt(sum(fNormal.^2,2)); 
fNormal=fNormal./denom(:,[1 1 1]); 

A=fNormal(:,1); 
B=fNormal(:,2);
C=fNormal(:,3);
D=-sum(fNormal.*p2,2);

isIn=zeros(length(p2),1);
pointsIn=zeros(length(testPoints),1);
[lenA,col]=size(A);
[testPointsLen,col]=size(testPoints);

%Bounding Box
maxX=max(vert(face(:),1));
maxY=max(vert(face(:),2));
maxZ=max(vert(face(:),3));

minX=min(vert(face(:),1));
minY=min(vert(face(:),2));
minZ=min(vert(face(:),3));


%test whether each point is inside convex hull or not,
for n=1:testPointsLen
    %first bounding box check
    farHull   = testPoints(n,1)>maxX || testPoints(n,2)>maxY || testPoints(n,3)>maxZ;
    beforeHull= testPoints(n,1)<minX || testPoints(n,2)<minY || testPoints(n,3)<minZ;
    if farHull || beforeHull
       %point is outside bounding box 
    else    
        %eqaution of plane Ax+By+Cz+D
        %if isIn<0 then point is outside the hull 
        %if isIn=0 then point is on the hull
        %if isIn>0 then point is inside the hull
        isIn=A*testPoints(n,1)+B*testPoints(n,2)+C*testPoints(n,3)+D;       
        m=1;
        while m<=lenA && isIn(m)>=0
           m=m+1;   
        end
        if m==(lenA+1)
           pointsIn(n,1)=n;
        %else
           %point outside hull 
        end
    end
end
inPointsIndex=find(pointsIn);
inHullPoints=testPoints(inPointsIndex,:);

return