clear;close all;clc
%----Add the data to path include(rignal data 7311,center_pts without the outlier)
path=pwd;
path=strcat(path,'\Data');
addpath(path);
load center_pts.mat 
load connectPairTree.mat
load no_zero.mat



%-------------Find the Branch Point----------------------

[~,p_size]=size(pred);
temp=zeros(p_size,4);
temp(:,1:3)=no_zero(:,1:3);
ind=find(isnan(pred)==1);
for i=1:p_size
    if isnan(pred(i)) ||  pred(i)==0
            temp(i,4)=temp(i,4)-2; %use 2 for delete the root node
    else
       temp(pred(i),4)= temp(pred(i),4)+ 1;   
    end
end 
ind=find(temp(:,4)>=0);

[number,~]=size(ind);
ConnectNode=zeros(number,4);

for i=1:number
    ConnectNode(i,1:4)=temp(ind(i),1:4);
end

index_branch=find(ConnectNode(:,4)>=2);

[index,~]=size(index_branch);
BranchNode=zeros(index,4);
for i=1:index
    BranchNode(i,:)=ConnectNode(index_branch(i),:);
end

save BranchNode.mat BranchNode

%Plot the Branch Point & vessel Center Point
[n,~]=size(center_pts);
for i=1:n
 if ConnectNode(i,4)>=2
     plot3(center_pts(i,2),center_pts(i,1),center_pts(i,3),'.','Markersize',10,'MarkerEdgeColor','g');
 else
 
     plot3(center_pts(i,2),center_pts(i,1),center_pts(i,3),'.','Markersize',10,'MarkerEdgeColor','r');
 end

hold on
%line([X(i-1) X(i)], [Y(i-1) Y(i)],[Z(i-1) Z(i)],'linewidth',1);
axis([ 150 350 50 350 1 150])
view(2)
grid on
h=gca; 

 
title('3D Branch Detection','fontsize',14);
fh = figure(1);
set(fh, 'color', 'white'); 
 F=getframe;
 disp(i)
end

movie(F)
