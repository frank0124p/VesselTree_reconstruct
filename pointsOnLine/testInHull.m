%testInHull
p=rand(200,3);
K=convhulln(p,{'Qt'});
randP=2*rand(100,3);

h=patch('faces',K,'vertices',p,'facecolor','none');

%random points in 3d
line(randP(:,1),...
     randP(:,2),...
     randP(:,3),'marker','x','color','g','linestyle','none');

%tic
[inHullPoints,index]=inConvHull(p,K,randP);
%toc

%points inside hull
 line(inHullPoints(:,1),...
      inHullPoints(:,2),...
      inHullPoints(:,3),'marker','o','color','r','linestyle','none');
%or
%line(randP(index,1),...
%     randP(index,2),...
%     randP(index,3),'marker','d','color','b','linestyle','none');

axis equal
view(3)
