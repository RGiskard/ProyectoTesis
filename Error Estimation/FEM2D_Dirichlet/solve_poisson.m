% Solver 


[coords, elems, dirnodes] = set_mesh(1,1,40,20);

n=size(elems,1);
nvar=size(coords,1);
A=sparse(size(coords,1),size(coords,1));

for i=1:n
    idx = elems(i,:);
    M = local_matrix(coords(idx,:));
    A(idx,idx) = A(idx,idx) + M;
end

u=zeros(size(coords,1), 1);
b=zeros(size(coords,1), 1);

b(:)=1;


freenodes=setdiff(1:nvar,unique(dirnodes));
u(freenodes,1)=A(freenodes,freenodes)\b(freenodes,1);