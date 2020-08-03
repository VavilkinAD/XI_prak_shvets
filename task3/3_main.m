clear;
clc;
d = 0.8;
l = 1;
X1 = 3.6; X2 = 0;
Y1 = 0.8; Y2 = -2.4;
mu1 = 0.525; mu2 = 2.85;
eps = 0.1;
k = 1;
nu = 1;
x10 = 0;
dx10 = 10;
x20 = -0.65;
dx20 = 10;
ddelta0 = 0;
delta0 = 0.03;
%delta0 = 0.12;
sigma1 = sign(dx10);
sigma2 = sign(dx20);

syms delta ddelta x_1 v_1 real;
phi = asin(d/(l+delta));
R=k*delta/eps^2+nu*ddelta/eps;

Dddelta=ddelta^2*tan(phi)^2/(l+delta)+cos(phi)*(X1-X2-2*R*cos(phi)-(sigma1*mu1*abs(Y1-R*sin(phi))-sigma2*mu2*abs(Y2+R*sin(phi))));
dv1=X1-R*cos(phi)-mu1*sigma1*abs(Y1-R*sin(phi));

s{1} = 'function dydx = MyEquation(t,y)';
s{2} = 'dydx = zeros(4,1);';
s{3} = 'x_1=y(1);';
s{4} = 'v_1=y(2);';
s{5} = 'delta=y(3);';
s{6} = 'ddelta=y(4);';
s{7} = 'dydx(1) =  v_1 ;';
s{8} = ['dydx(2) = ' char(dv1) ';'];
s{9} = 'dydx(3) =  ddelta ;';
s{10} = ['dydx(4) = ' char(Dddelta) ';'];
filename = fullfile(pwd, 'MyEquation.m');   % Определяем полное имя файла
fid = fopen(filename, 'w');                 % Открываем файл на запись
fprintf(fid, '%s\n', s{:});                 % Записываем содержимое
fclose(fid);                                % Закрываем файл

[T,Y] = ode45('MyEquation',0:0.01:5, [x10 dx10 delta0 ddelta0]); % Решаем ОДУ
delete(filename);

figure('Name','Phase portrait','NumberTitle','off');
plot(Y(:,3),Y(:,4))
title('Phase portrait');
xlabel('\delta');
ylabel('dot \delta');

endind1=size(Y);
endind=endind1(1);

Rmass=zeros(endind,2);
Rmass(:,1)=T;
    for i=1:endind
        Rtemp=subs(R,[delta ddelta],[Y(i,3) Y(i,4)]);
        Rtemp=double(Rtemp);
        Rmass(i,2)=Rtemp;
    end
    
figure('Name','R(t)','NumberTitle','off');
plot(Rmass(:,1),Rmass(:,2))
xlabel('t');
ylabel('R(t)');


figure('Name','Speed','NumberTitle','off');
plot(T,Y(:,2))
title('Speed');
xlabel('t');
ylabel('v_1');