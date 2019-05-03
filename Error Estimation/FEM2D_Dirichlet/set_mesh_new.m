[coords, elems, dirichlet, neumann] = set_mesh_new(nx,ny)
% 

dx = 1/nx;
dy = 1/ny;

nverts = (nx+1)*(ny+1);
nelems = nx*ny;
nbdryfaces = 2*nx + 2*ny;



%% VERTICES
coords = zeros(nverts,2);
for i=1:nverts
    coords(i,1) = dx * mod( (i-1), (nx+1) );
    coords(i,2) = dy * floor( (i-1)/(nx+1) );
end

%% ELEMENTS
mesh.elems = zeros(nelems, 3);

mesh.nfaces = mesh.nx * (mesh.ny+1) + mesh.ny * (mesh.nx+1);

for i=1:mesh.nelems
    tmpy = floor((i-1)/(mesh.nx));
    tmpx = mod( i-1,mesh.nx);
    tmpz = tmpx + tmpy*(mesh.nx+1) + 1;
    
    % Vertices
    mesh.elems(i,1) = tmpz;
    mesh.elems(i,2) = tmpz + 1;
    mesh.elems(i,3) = tmpz + mesh.nx  + 2;
    mesh.elems(i,4) = tmpz + mesh.nx  + 1;
    
end

%%% PLOT THE MESH
% uzeros = zeros(mesh.nverts,1);
% trisurf(mesh.elems(:,1:4), mesh.coords(:,1),mesh.coords(:,2), uzeros,'facecolor','interp')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SET DIRICHLET BOUNDARY FACES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Left and Right Boundaries are set Dirichlet
%    VERTEX1   VERTEX2   FACE_NUMBER
mesh.n_dirichlet = 2*mesh.ny;
mesh.dirichlet = zeros(mesh.n_dirichlet, 3);

for i=1:mesh.ny
    tmpz = (i-1)*(mesh.nx+1) + 1;
    mesh.dirichlet(i,1) = tmpz + (mesh.nx+1) ;
    mesh.dirichlet(i,2) = tmpz ;
    mesh.dirichlet(i,3) = (mesh.nx+1) + (i-1)*(2*mesh.nx+1);
    
    tmpz = i*(mesh.nx+1);
    mesh.dirichlet(mesh.ny+i, 1) = tmpz ;
    mesh.dirichlet(mesh.ny+i, 2) = tmpz + mesh.nx+1 ;
    mesh.dirichlet(mesh.ny+i, 3) = i*(2*mesh.nx+1) ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  SET NEUMANN BOUNDARY FACES (UP and Down Boundaries)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    VERTEX1  VERTEX2  FACE_NUMBER

mesh.n_neumann = 2*mesh.nx;
mesh.neumann = zeros(mesh.n_neumann, 3);

for i = 1:mesh.nx
    mesh.neumann(i,1) = i;
    mesh.neumann(i,2) = i+1;
    mesh.neumann(i,3) = i;

    mesh.neumann(mesh.nx + i,1) = mesh.nverts - i + 1;
    mesh.neumann(mesh.nx + i,2) = mesh.nverts - i ;
    mesh.neumann(mesh.nx + i,3) = mesh.nx*(2*mesh.nx+1) + mesh.nx - (i-1);
end
