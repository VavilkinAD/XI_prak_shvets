%% Simple Pendulum 
simplemass1 = poincare(100, 0.1, 1, 0, 0.1, 0);
simplemass2 = poincare(100, 0.1, 0.5, 0, 0.1, 0);
simplemass3 = poincare(100, 0.1, 0.1, 0, 0.1, 0); %separatrix
simplemass4 = poincare(100, 1, 0.01, 0, 0.1, 0);

figure('Name', 'Simple Pendulum');
hold on;
plot(simplemass1(:,1),simplemass1(:,2),'.');
hold on
plot(simplemass1(:,3),simplemass1(:,4),'.');
hold on
plot(simplemass2(:,1),simplemass2(:,2),'.');
hold on
plot(simplemass2(:,3),simplemass2(:,4),'.');
hold on
plot(simplemass3(:,1),simplemass3(:,2),'.');
hold on
plot(simplemass3(:,3),simplemass3(:,4),'.');
hold on
plot(simplemass4(:,1),simplemass4(:,2),'.');
hold on
plot(simplemass4(:,3),simplemass4(:,4),'.');
%% A sprt(2)
Amore2mass = poincare(100,0.1,0.1, 1.5, 0.1, 0.1);
Aless2mass = poincare(100,0.1,0.1, 1.4, 0.1, 0.1);

figure('Name', 'A > sprt(2)');
hold on;
plot(Amore2mass(:,1),Amore2mass(:,2),'.');
hold on
plot(Amore2mass(:,3),Amore2mass(:,4),'.');

figure('Name', 'A < sprt(2)');
hold on
plot(Aless2mass(:,1),Aless2mass(:,2),'.');
hold on
plot(Aless2mass(:,3),Aless2mass(:,4),'.');
%% Chaos
chaosmass1 = poincare(100, 0.1, 1, 1, 0.1, 0);
chaosmass2 = poincare(100, 0.1, 0.5, 1, 0.1, 0);
chaosmass3 = poincare(100, 0.1, 0.1, 1, 0.1, 0); 
chaosmass4 = poincare(100, 1, 0.01, 1, 0.1, 0);

figure('Name', 'Chaos');
hold on;
plot(chaosmass1(:,1),chaosmass1(:,2),'.');
hold on
plot(chaosmass1(:,3),chaosmass1(:,4),'.');
hold on
plot(chaosmass2(:,1),chaosmass2(:,2),'.');
hold on
plot(chaosmass2(:,3),chaosmass2(:,4),'.');
hold on
plot(chaosmass3(:,1),chaosmass3(:,2),'.');
hold on
plot(chaosmass3(:,3),chaosmass3(:,4),'.');
hold on
plot(chaosmass4(:,1),chaosmass4(:,2),'.');
hold on
plot(chaosmass4(:,3),chaosmass4(:,4),'.');
%% Attractor
attmass=poincare(15000, 0.1, 1, 40, 0.1, 2);

figure('Name', 'Attractor');
hold on;
plot(attmass(:,1),attmass(:,2),'.');
