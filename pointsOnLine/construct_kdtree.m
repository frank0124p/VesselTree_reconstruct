clear all 
close all
load skel1.mat
[r,c,slice]=size(skel1);
Ori=skel1;
result=zeros(r,c,slice);
tic 
% iteration=5;
% for itr=1:iteration

%Put all the Vessel points in the Reference------------
k=1; %Counter for select points
n=r*c*slice;
Reference = zeros(n,4);% all node in volume


for s=1:slice  %Slice
   for j=1:r  % X axis
      for i=1:c  % Y axis
        Reference(k,1)=i;
        Reference(k,2)=j;
        Reference(k,3)=s;
        Reference(k,4)=skel1(j,i,s);
        k=k+1;
      end
   end
end

 z=Reference(:,4);
 [ind]=find(z);

 [m,~]=size(ind);
 no_zero=zeros(m,4);
 for i=1:m
     no_zero(i,:)=Reference(ind(i),:);
 end
 % KNN search------------------------------------------------------
 disp('Start Search nearst point...');

k=8;
temp_shortest_point=zeros(m,k);
 for i=1:m
  [pts neighborDistances] = kNearestNeighbors(no_zero,no_zero(i,:), k);
%   [pts] = knnsearch(no_zero(i,:),no_zero,k);

 temp_shortest_point(i,:)=pts;
 disp(i);
 end

shortest_point_index=temp_shortest_point(:,k);
%Assign the point through index 
 shortest_point=zeros(m,4);

 for i=1:m
shortest_point(i,:)=no_zero(shortest_point_index(i),:);
 end   
disp('End Search nearst point...');

p1=shortest_point(:,1:3);
p2=no_zero(:,1:3);
[n,~]=size(p1);
numPoints=1000;
nearst_point_cell = cell(n,1);

disp('Start Interpolation...');
% for i=1:n
% points=pointsOnLine(p1(i,:),p2(i,:),numPoints);
% nearst_point_cell{i}=points;
% 
% 
% end

for i=1:n
 [X Y Z] = bresenham_line3d(p1(i,:),p2(i,:));
 X=X';Y=Y';Z=Z';
points=[X Y Z];
nearst_point_cell{i}=points;

end


disp('End Interpolation...');

disp('Start nearst point assign value...');

for i=1:n 
 temp=nearst_point_cell{i};
 [numPoints,~]=size(temp);
%  temp=round(temp);
   for j=1:numPoints
          x=temp(j,1);
          y=temp(j,2);
          z=temp(j,3);
          result(y,x,z)=1;
   end
end
disp('End nearst point assign value...');

% itr=itr+1;
% skel1=skel12;
% end
figure,imshow(max(Ori,[],3));

figure,imshow(max(result,[],3));

fv = isosurface(Ori,0.3);  
stlwrite('vein_ori.stl', fv);

fv = isosurface(result,0.3);  
stlwrite('vein.stl', fv);



skel1_result = Skeleton3D(result);
skel1_result = Skeleton3D(skel1_result);
skel1_result = Skeleton3D(skel1_result);

figure,imshow(max(skel1_result,[],3));
fv = isosurface(skel1_result,0.3);  
stlwrite('vein_knnhigh.stl', fv);
toc 