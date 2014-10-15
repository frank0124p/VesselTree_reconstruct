%testpontsonline

p1=[-0.5 -0.9 3]; %point1
p2=[1 -3.5 5]; %point2

%p1=[0 0 0]; %point1
%p2=[1 0 0]; %point2

line(p1(1),p1(2),p1(3),'marker','x','color','r')
line(p2(1),p2(2),p2(3),'marker','x','color','r')

numPoints=30;
points=pointsOnLine(p1,p2,numPoints);
line(points(:,1),points(:,2),points(:,3),'marker','o');

axis equal
view(3)