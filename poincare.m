function mass = poincare(N,q0,p0,A,eps,mu)
mass=zeros(N,4);
mass(1,1)=q0;
mass(1,2)=p0;

 for ind = 2:N
    [T,Y]=ode45(@(t,y) D(t,y,A,eps,mu),[0:0.001:2*pi*eps],[mass(ind-1,1),mass(ind-1,2)]);
    mass(ind,1)=norming(Y(end,1));
    mass(ind,2)=Y(end,2);
 end
 
mass(1,3)=q0;
mass(1,4)=-p0;

 for ind = 2:N
    [T,Y]=ode45(@(t,y) D(t,y,A,eps,mu),[0:0.001:2*pi*eps],[mass(ind-1,3),mass(ind-1,4)]);
    mass(ind,3)=norming(Y(end,1));
    mass(ind,4)=Y(end,2);
 end
end
function dy = D(t,y,A,eps,mu)
dy = zeros(2,1);  
dy(1)=y(2)+A*sin(y(1))*sin(t/eps);
dy(2)=-A*y(2)*cos(y(1))*sin(t/eps)-A^2*sin(y(1))*cos(y(1))*sin(t/eps)^2+sin(y(1))-mu*(y(2)+A*sin(y(1))*sin(t/eps));
end
function[Y_norm] = norming(Y1)
Y_norm=mod(Y1+pi,2*pi)-pi;
end