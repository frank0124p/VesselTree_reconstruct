load center_pts.mat 
load connectPairTree.mat

[n,~]=size(center_pts);

for i=1:n
plot3(center_pts(i,2),center_pts(i,1),center_pts(i,3),'.','Markersize',10,'MarkerEdgeColor','r')
hold on
%line([X(i-1) X(i)], [Y(i-1) Y(i)],[Z(i-1) Z(i)],'linewidth',1);
axis([ 150 300 150 350 1 150])
view(2)
grid on
h=gca; 
get(h,'fontSize') 
set(h,'fontSize',12)
 
title('3D Branch Detection','fontsize',14);
fh = figure(1);
set(fh, 'color', 'white'); 
 F=getframe;
end

movie(F)
