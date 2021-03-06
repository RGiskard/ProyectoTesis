function [coords, element, dirnodes] = set_mesh(a, b, nx, ny)
%
%  Domain [0,a] x [0,b]
%

nodesx = nx + 1;
nodesy = ny + 1;

deltax = a/nx;
deltay = b/ny;


% COORDINATES : EXTENDED DOMAIN NODESX+1 AND NODESY+1
coords = zeros( (nodesx)*(nodesy), 2);
for i=1:(nodesx)
    x = (i-1)*deltax;
    
    for j=1:(nodesy)
        y = (j-1)*deltay;
        idx = i+(j-1)*(nodesx);
        
        coords(idx, 1) = x;
        coords(idx, 2) = y;
    end
end

% ELEMENTS
%  element connectivity for variables
element = zeros( 2*(nx)*(ny), 3);

% LOOP 1:
for i=1:nx
    for j=1:ny
        idx = i + (j-1)*2*nx; 
        element(idx,1) = i + (j-1)*nodesx;
        element(idx,2) = element(idx,1)+1;
        element(idx,3) = element(idx,1)+nodesx+1;
    end
end


% LOOP 2:
for i=1:nx
    for j=1:ny
        idx = i + (j-1)*2*nx + nx ;
        element(idx,1) = i + (j-1)*nodesx;
        element(idx,2) = element(idx,1) + nodesx+1;
        element(idx,3) = element(idx,2) - 1;
    end
end

% dirnodes
dirnodes = zeros(2*nx+2*ny, 2);
for i=1:nx
    dirnodes(i,1) = i;
    dirnodes(i,2) = i+1;
end

for i=1:nx
    idx = nx+i;
    dirnodes(idx,1) = nodesx*ny + i + 1;
    dirnodes(idx,2) = dirnodes(idx,1) -1;
end

for i=1:ny
    idx = 2*nx + i;
    dirnodes(idx,1) = nodesx*i ;
    dirnodes(idx,2) = nodesx*(i+1);
end

for i=1:ny
    idx = 2*nx+ny+i;
    dirnodes(idx,1) = nodesx*i + 1;
    dirnodes(idx,2) = dirnodes(idx,1) - nodesx;
  
end
