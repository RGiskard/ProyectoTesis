function show_nodes(coords)

for j=1:size(coords,1)
    mystr = int2str(j);
   text(coords(j,1), coords(j,2), mystr); 
end