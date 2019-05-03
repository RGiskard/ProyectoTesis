function f = evalf(coord)
x=coord(:,1);
y=coord(:,2);

n=size(coord,1);


f=zeros(n,1);

% EXEMPLO 1
%f = 18*coord(:,2); % 18*y

% EXEMPLO 2
% Solucao Exata:  10xysin(6x^2) - cos(10y) + exp(x-1);
f = 360*x.*y.*cos(6.*x.*x) - 1440*x.*x.*x.*y.*sin(6*x.*x) + exp(x-1);
f = - f - 100*cos(10*y);

% EXEMPLO 3
% delta = 0.02;
% for i=1:n
%         if (x(i)>(0.5-delta))&&(x(i)<(0.5+delta))
%             if (y(i)>(0.5-delta))&&(y(i)<(0.5+delta))
%                 f(i) = 10.0;
%             end
%         end
% end




