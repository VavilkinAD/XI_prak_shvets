%% Symbol part
g=9.8;
m=[1,1];
l=[1,1];
a=2;

phi=sym('phi_%d',1:2,'real');
omega=sym('omega_%d',1:2,'real');
syms t nu positive;
r=sym('r%d_%d',2,'real');

r=subs(r,r(1,1),l(1)*sin(phi(1)));
r=subs(r,r(1,2),l(1)*cos(phi(1))+a/nu*cos(nu*t));
r=subs(r,r(2,1),l(1)*sin(phi(1))+l(2)*sin(phi(2)));
r=subs(r,r(2,2),l(1)*cos(phi(1))+l(2)*cos(phi(2))+a/nu*cos(nu*t));

v= diff(r,t)+diff(r,phi(1))*omega(1)+diff(r,phi(2))*omega(2);
Ten=1/2*(m(1)*v(1,:)*v(1,:)'+m(2)*v(2,:)*v(2,:)');
V=g*(m(1)*r(1,2)+m(2)*r(2,2));
L=Ten-V;

p=sym('p_%d',1:2,'real');

P=p-[diff(L,omega(1)),diff(L,omega(2))];

dot_q=sym('dot_q_%d',1:2,'real');
%dot_q = solve(P==0,omega) <- this does not work, so I made this:

dot_q(1)=solve(P(1),omega(1));
P(2)=subs(P(2),omega(1),dot_q(1));
dot_q(2)=solve(P(2),omega(2));
dot_q(1)=subs(dot_q(1),omega(2),dot_q(2));
dot_q=simplify(dot_q);


H=p*omega'-L;
H=subs(H,omega(1),dot_q(1));
H=subs(H,omega(2),dot_q(2));
H=simplify(H);
symvar(H)


Hmean=int(H, t, 0, 2*pi/nu);
Hmean=simplify(Hmean);
Hmean=Hmean*nu/(2*pi);
Hmean=simplify(Hmean);
%symvar(Hmean)



%Heq=[phi_1,phi_2,p_1,p_2]
Heq=[diff(H,p(1)),diff(H,p(2)),-diff(H,phi(1)),-diff(H,phi(2))];
Heq=simplify(Heq);

Heqmean=[diff(Hmean,p(1)),diff(Hmean,p(2)),-diff(Hmean,phi(1)),-diff(Hmean,phi(2))];
Heqmean=simplify(Heqmean);

%% Count error
t0=0;
tfin=0.5;
y0=[1,1,2,2];

NU=(330:40:10+20*40);
endind1=size(NU);
endind=endind1(1,2);
err=zeros(endind,8);
for i=1:endind
%(H,y0,p_1,p_2,phi_1,phi_2,t0,tfin,NU)
[T,Y] =         solveHeq(Heq,    y0,t0,tfin,NU(i),nu);
[Tmean,Ymean] = solveHeq(Heqmean,y0,t0,tfin,NU(i),nu);
    err(i,1)=NU(i);
    for j=2:7
    err(i,j)=NU(i)*max(abs(Y(:,j-1)-Ymean(:,j-1)));
    end
    err(i,8)=NU(i)*max(sqrt((Y(:,2)-Ymean(:,2)).^2+(Y(:,3)-Ymean(:,3)).^2+(Y(:,4)-Ymean(:,4)).^2+(Y(:,5)-Ymean(:,5)).^2 ));
    
     figure('Name','phi_1','NumberTitle','off');
     plot(T,Y(:,1))
     title('\phi_1');
     xlabel('t');
     ylabel('\phi_1');
     hold on
     plot(T,Ymean(:,1))
    
    
    
end
%% Ploting
%{
figure('Name','Error vec','NumberTitle','off');
plot(err(:,1),err(:,8))
title('Error vec');
xlabel('\nu');
ylabel('Error vec');
%}
figure('Name','Error phi_1','NumberTitle','off');
plot(err(:,1),err(:,2))
title('Error \phi_1');
xlabel('\nu');
ylabel('Error \phi_1');
%{
figure('Name','Error p_1','NumberTitle','off');
plot(err(:,1),err(:,4))
title('Error p_1');
xlabel('\nu');
ylabel('Error p_1');

figure('Name','Error dot q_1','NumberTitle','off');
plot(err(:,1),err(:,6))
title('Error dot q_1');
xlabel('\nu');
ylabel('Error dot q_1');

figure('Name','Error phi_2','NumberTitle','off');
plot(err(:,1),err(:,3))
title('Error \phi_2');
xlabel('\nu');
ylabel('Error \phi_2');

figure('Name','Error p_2','NumberTitle','off');
plot(err(:,1),err(:,5))
title('Error p_2');
xlabel('\nu');
ylabel('Error p_2');

figure('Name','Error dot q_2','NumberTitle','off');
plot(err(:,1),err(:,7))
title('Error dot q_2');
xlabel('\nu');
ylabel('Error dot q_2');
%}
