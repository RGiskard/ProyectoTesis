function show_elements(coords,elements,nx,ny)

ne=size(elements,1);
nc=size(coords,1); 

hold on;
for j=1:(2*nx*ny)
   if (elements(j,1)>0)
       trimesh( elements(j,:), coords(:,1), coords(:,2) );
   end
end

for j=(2*nx*ny+1):ne
   if (elements(j,1)>0)
       trimesh( elements(j,:), coords(:,1), coords(:,2) );
   end
end
