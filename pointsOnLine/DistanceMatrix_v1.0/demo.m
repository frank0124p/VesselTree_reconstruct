clear;clc;close all;
load no_zero.mat %load all node in the result
load skel1.mat
[r,c,s]=size(skel1);
result=zeros(r,c,s);
shortest_result=zeros(r,c,s);
tic;

D=distanceMatrix(no_zero); % distance matrix

[n,~]=size(no_zero);

connect_matrix=zeros(n,n);
threshold_number=10;
%Choose the number of nearst distance in the distance map
for i=1:n
    temp=D(:,i);
    [~,index]=sort(temp);
    for j=1:threshold_number
        connect_matrix(index(j),i)=D(index(j),i);
    end
    connect_matrix(i,i)=0;
end  
%row and column do it one time each
for i=1:n
    temp=D(i,:);
    [~,index]=sort(temp);
    for j=1:threshold_number
        connect_matrix(i,index(j))=D(i,index(j));
    end
    connect_matrix(i,i)=0;
end 



S = sparse(connect_matrix);

[Tree, pred] = graphminspantree(S);
%Minimal Spanning tree-----------------
[r,c]=find(Tree);
[ind,~]=size(r);
for i=1:ind
   node1= no_zero(r(i),1:3);
   node2= no_zero(c(i),1:3);
   points=pointsOnLine(node1,node2,1000);
   points=round(points);
   [pts_n,~]=size(points);
   for j=1:pts_n
       x=points(j,1);
       y=points(j,2);
       z=points(j,3);
     result(y,x,z)=1;  
   end
%    normal=[y x z]-[points(1,2) points(1,1) points(1,3)];
%    circlePlane3D([points(1,2) points(1,1) points(1,3)], normal, 5, 0.2, [0 0 1]); 

end

%Shortest Spanning tree-----------------
% for allnode=1:n
% [dist, path, predshort] = graphshortestpath(S,allnode);
% for i=1:n
% temp=path{i};
% if temp==inf
%     break;
% end
% [~,path_n]=size(temp);
% for j=1:path_n
%     X=no_zero(temp(:,j),1);
%     Y=no_zero(temp(:,j),2);
%     Z=no_zero(temp(:,j),3);
%     shortest_result(Y,X,Z)=1;
% end
% end
% end
figure,imshow(max(skel1,[],3));

figure,imshow(max(result,[],3));

%smooth the result by gaussian
allconnectnode = smooth3(result,'gaussian',[9 9 9]);
figure,imshow(max(allconnectnode,[],3));




% figure,imshow(max(shortest_result,[],3));

fv = isosurface(result,0.1);  
stlwrite('vein_MST.stl', fv);

fv = isosurface(allconnectnode,0.1);  
stlwrite('test.stl', fv);




toc;