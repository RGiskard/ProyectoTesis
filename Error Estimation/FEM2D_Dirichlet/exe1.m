%
function exe1(coords, elements)
% interpolate function

n=size(coords,1);
u=zeros(n,1);


for i=1:n
    x = coords(i,1);
    y = coords(i,2);
    u(i,1) = sin(x)*cos(y);
end
trisurf(elements,coords(:,1), coords(:,2), u);

% basis function



% support of basis function