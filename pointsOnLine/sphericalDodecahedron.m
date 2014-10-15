function sphericalDodecahedron
%example using pointsOnLine function
%spherical dodecahedron
phi=(1+sqrt(5))/2; %golden ratio
vert=[1 1 1
     1 1 -1
     1 -1 1
    1 -1 -1
    -1 1 1
    -1 1 -1
    -1 -1 1
    -1 -1 -1
    0 1/phi phi
    0 1/phi -phi
    0 -1/phi phi
    0 -1/phi -phi
    1/phi phi 0
    1/phi -phi 0
    -1/phi phi 0
    -1/phi -phi 0
    phi 0 1/phi
    phi 0 -1/phi
    -phi 0 1/phi
    -phi 0 -1/phi];
            
face=[1 13 2 18 17;
       1 9 5 15 13;
       13 15 6 10 2;
       2 10 12 4 18;
       18 17 3 14 4;
       1 9 11 3 17;
       5 9 11 7 19;
       15 5 19 20 6;
       6 20 8 12 10;
       20 19 7 16 8;
       8 12 4 14 16;
       11 7 16 14 3];

pairs=uniquePair(face);%get edges of dodecahedron

numPoints=30; %number of points between vertices

tubeLineX=zeros(length(pairs),numPoints);
tubeLineY=zeros(length(pairs),numPoints);
tubeLineZ=zeros(length(pairs),numPoints);

for n=1:length(pairs)
    
    verNo=pairs(n,:);
    newPoints=pointsOnLine(vert(verNo(1),:),vert(verNo(2),:),numPoints);
    
    [xnew,ynew,znew]=onSphere(newPoints(:,1),newPoints(:,2),newPoints(:,3));

    line(xnew,ynew,znew);
    
    tubeLineX(n,:)=xnew;
    tubeLineY(n,:)=ynew;
    tubeLineZ(n,:)=znew;
    
end
axis equal
view(3)
figure

for n=1:length(pairs)
    
    verts = {[tubeLineX(n,:)' tubeLineY(n,:)' tubeLineZ(n,:)']};
    daspect([1 1 1])

    h=streamtube(verts,0.1);
    set(h,'edgecolor','none');
end


axis equal
view(3)
%shading interp
%camlight; lighting phong

function pair=uniquePair(faces);
%function uniquePair returns the edges of dodecahedron
[row,col]=size(faces);
pair=[];
for n=1:row
    index=faces(n,:);
    for m=1:col-1
        pair=[pair;index(m) index(m+1)];
                 
    end
    pair=[pair;index(1) index(m+1)];
end
pair=unique(pair,'rows');
return   


function  [xnew,ynew,znew]=onSphere(x,y,z)
%project a point on sphere
S = sqrt(1./(x.^2+y.^2+z.^2));
xnew = x.*S;
ynew = y.*S;
znew = z.*S;   
return