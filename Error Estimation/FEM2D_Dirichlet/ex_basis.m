n=4;

[coords,elements]=set_mesh(1,1,n,n);
n=size(coords,1);
u=zeros(n,1);

u(13,1) = 1;

hold on

trisurf(elements,coords(:,1), coords(:,2), u, 'FaceColor', 'interp', 'LineWidth', 2 );
%colormap('copper');

alpha(0.5)


% SHOW VERTEX
%  plot( coords(13,1), coords(13,2), 'ro', 'LineWidth', 3, 'MarkerSize', 15);
% show Vertex
% 
%  
%