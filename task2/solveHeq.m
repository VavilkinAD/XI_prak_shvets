function [T,Y] = solveHeq(Heq,y0,t0,tfin,NU,nu)
%Heq=subs(Heq,[phi_1,phi_2,p_1,p_2],[sym('y(1)'), sym('y(2)'),sym('y(3)'), sym('y(4)')]);
Heq=subs(Heq,nu,NU);
step=2*pi/(40*NU);
%symvar(Heq)
s{1} = 'function dydx = MyEquation(t,y)';
s{2} = 'dydx = zeros(4,1);';
s{3} = 'phi_1=y(1);';
s{4} = 'phi_2=y(2);';
s{5} = 'p_1=y(3);';
s{6} = 'p_2=y(4);';
s{7} = ['dydx(1) = ' char(Heq(1)) ';'];
s{8} = ['dydx(2) = ' char(Heq(2)) ';'];
s{9} = ['dydx(3) = ' char(Heq(3)) ';'];
s{10} = ['dydx(4) = ' char(Heq(4)) ';'];
filename = fullfile(pwd, 'MyEquation.m');   % Определяем полное имя файла
fid = fopen(filename, 'w');                 % Открываем файл на запись
fprintf(fid, '%s\n', s{:});                 % Записываем содержимое
fclose(fid);                                % Закрываем файл

[T,Y] = ode45('MyEquation',t0:step:tfin, y0); % Решаем ОДУ


endind1=size(Y);
endind=endind1(1,2);
    for k=1:endind
        Heq(1)=subs(Heq(1),{sym('phi_1'),sym('phi_2'),sym('p_1'),sym('p_2'),sym('t')},{Y(k,1),Y(k,2),Y(k,3),Y(k,4),T(k)});
        %{
        Heq(1)=subs(Heq(1),sym('phi_1'),Y(k,1));
        Heq(1)=subs(Heq(1),sym('phi_2'),Y(k,2));
        Heq(1)=subs(Heq(1),sym('p_1'),Y(k,3));
        Heq(1)=subs(Heq(1),sym('p_2'),Y(k,4));
        Heq(1)=subs(Heq(1),sym('t'),T(k));
        %}
        Y(k,5)=Heq(1);
        Heq(2)=subs(Heq(2),{sym('phi_1'),sym('phi_2'),sym('p_1'),sym('p_2'),sym('t')},{Y(k,1),Y(k,2),Y(k,3),Y(k,4),T(k)});
        %{
        Heq(2)=subs(Heq(2),sym('phi_1'),Y(k,1));
        Heq(2)=subs(Heq(2),sym('phi_2'),Y(k,2));
        Heq(2)=subs(Heq(2),sym('p_1'),Y(k,3));
        Heq(2)=subs(Heq(2),sym('p_2'),Y(k,4));
        Heq(2)=subs(Heq(2),sym('t'),T(k)); 
        %}
        Y(k,6)=Heq(2);
        
    end
%}
delete(filename);
end

