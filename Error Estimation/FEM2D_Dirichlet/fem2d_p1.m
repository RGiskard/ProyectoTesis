%

% CREATE THE MESH
a=1;
b=1;


nx=10;
ny=nx;

[coords, element, dirnodes] = set_mesh(a, b, nx, ny);

n = size(coords,1); % QUANTIDADE DE VERTICES = QTDE. VARIAVEIS
nelem=size(element,1); % QUANTIDADE DE ELEMENTOS

% CRIACAO DA MATRIZ ESPARSA DO SISTEMA LINEAR
A = sparse(n,n);

% LOOP PARA CALCULO DA MATRIZ DE RIGIDEZ (STIFFNESS MATRIX)
for j=1:nelem
    idx = element(j,:);
    M_local = local_matrix( coords(idx,:) );
    A(idx,idx) = A(idx,idx) + M_local;
 
end


% CRIA VETORES U E B DO SISTEMA LINEAR
u = zeros(n,1);
b = zeros(n,1);

% CRIA O LADO DIREITO
for j=1:nelem
     idx = element(j,:);
   b(idx,1) = b(idx,1) + ...
     det([1,1,1; coords(idx,:)']) * ...
     evalf(  sum(coords(idx,:))/3  )/6;
end

% IMPOE CONDICAO DIRICHLET
dirichlet = unique(dirnodes);
u(dirichlet,1) = set_dirichlet( coords(dirichlet,:) );
b = b - A*u;

% RESOLVE O SISTEMA LINEAR COM CONDICAO DE DIRICHLET NA FRONTEIRA
freenodes =setdiff(1:n, dirichlet) ;

u(freenodes,1) = A(freenodes,freenodes)\b(freenodes,1);

trisurf(element, coords(:,1), coords(:,2), u, 'facecolor', 'interp');
view(-30,40);
title('Solucao Elementos Finitos');

figure;
uex = uexata(coords(:,1), coords(:,2) );
trisurf(element, coords(:,1), coords(:,2), uex, 'facecolor', 'interp');
view(-30,40);
title('Solucao Exata - Interp. Linear');

figure;
e = abs(uex-u);
trisurf(element, coords(:,1), coords(:,2), e, 'facecolor', 'interp');
view(-30,40);
title('Erro');
max(e)

% MOSTRA F
% f = evalf(coords);
% figure;
% trisurf(element, coords(:,1), coords(:,2), f, 'facecolor', 'interp');
% title('Function f(x)');




