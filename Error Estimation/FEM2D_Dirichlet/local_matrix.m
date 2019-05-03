function M = local_matrix(coords)

M = zeros(3,3);

x1=coords(1,1);
x2=coords(2,1);
x3=coords(3,1);

y1=coords(1,2);
y2=coords(2,2);
y3=coords(3,2);

a = x2-x1;
b = x3-x1;
c = y2-y1;
d = y3-y1;

detB = a*d-b*c;

Q = (1/(detB*detB))*[ (d*d+b*b)  -(c*d)-(a*b) ; -c*d-a*b   c*c+a*a ];


v = [ -1 -1; 1 0 ; 0 1];
for j=1:3
    for i=1:3
        M(i,j) = 0.5*abs(detB)* v(i,:)*Q*transpose(v(j,:));
    end
end


% M = 0.5*abs(detB)*v*Q*transpose(v);

