function  v = set_dirichlet(coords)
n=size(coords,1);

% SOLUCOES 1 E 2;
v = uexata(coords(:,1), coords(:,2) );

% exemplo 3;
% v = zeros(n,1);
