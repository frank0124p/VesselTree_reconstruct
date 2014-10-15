clear all
tic 
load Point.mat
p1=shortest_point(:,1:3);
p2=no_zero(:,1:3);
[n,~]=size(p1);
numPoints=10;
mat_array = cell(n,1);
temp=ones(numPoints,4);
for i=1:n
points=pointsOnLine(p1(i,:),p2(i,:),numPoints);
temp(:,1:3)=points;
mat_array{i}=temp;
disp(i);
end
% mat_array{i}
toc