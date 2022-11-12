clear all
clc

%------------------ Desenvolvido por Filipe Pacheco ---------------------

Fi  =   10;      %Vaz�o de carga;
F   =   Fi;
APi =   .7;      %Composi��o de A na carga;
AP  =   APi;
BPi =   .3;      %Composi��o de B na carga;
BP  =   BPi;
Ri  =   20;      %Vaz�o de Refluxo;
R   =   Ri;
Vi  =   04;      %Vaz�o de vapor;
V   =   Vi;
P   =   01;      %Press�o de opera��o da coluna;
LAA =   01;      %Vaz�o de l�quido ascendente - A
LAB =   00;      %Vaz�o de l�quido ascendente - B
LDA =   01;      %Vaz�o de l�quido descendente - A
LDB =   00;      %Vaz�o de l�quido descendente - B
NVT =   02;      %N�vel do vaso de topo;
NVF =   01;      %N�vel de vaso de fundo;

for i=1:49
    V=[V Vi];
end
for i=1:99
    R=[R Ri];
end
for i=1:69
    AP=[AP APi];
end
for i=1:59
    BP=[BP BPi];
end
for i=1:49
    F=[F Fi];
end

for i=1:500
    
[LAA,LDA]  = SIM1(F,AP,R,V,P,LAA,LDA);             %Vaz�o de l�quido Ascendente e Descendente - A
[LAB,LDB]  = SIM2(F,BP,R,V,P,LAB,LDB);             %Vaz�o de l�quido Ascendente e Descendente - B
[NVT,NVF]  = SIM3(LAA,LDA,LAB,LDB,NVT,NVF,R);      %N�vel de topo e de fundo


% if i >150
%     Vi=5;
% end
% if i>400
%     BPi=.2;
%     APi=.8;
% end
% if i>600
%    Ri = 20; 
% end
% if i>800
%     Fi=8;
% end

F   = [F(2:size(F,2)) Fi];
V   = [V(2:size(V,2)) Vi];    
R   = [R(2:size(F,2)) Ri];
AP  = [AP(2:size(AP,2)) APi];
BP  = [BP(2:size(BP,2)) BPi];
end
t=0:1:i;

figure(1)
subplot(2,1,1)
hold on
plot(t,LAA)
title('Vaz�o de LAA')
xlabel('Tempo (min)')
ylabel('Vaz�o (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDA)
title('Vaz�o de LDA')
xlabel('Tempo (min)')
ylabel('Vaz�o (ton/h)')

figure(2)
subplot(2,1,1)
hold on
plot(t,LAB)
title('Vaz�o de LAB')
xlabel('Tempo (min)')
ylabel('Vaz�o (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDB)
title('Vaz�o de LDB')
xlabel('Tempo (min)')
ylabel('Vaz�o (ton/h)')

figure(3)
subplot(2,1,1)
hold on
plot(t,100*LAA./(LAA+LAB))
title('Concentra��o de A no topo')
xlabel('Tempo (min)')
ylabel('Concentra��o (%)')
subplot(2,1,2)
hold on
plot(t,100*LAB./(LAA+LAB))
title('Concentra��o de B no topo')
xlabel('Tempo (min)')
ylabel('Concentra��o (%)')

figure(4)
subplot(2,1,1)
hold on
plot(t,NVT)
title('N�vel de Topo')
xlabel('Tempo (min)')
ylabel('N�vel (m)')
subplot(2,1,2)
hold on
plot(t,NVF)
title('N�vel de Fundo')
xlabel('Tempo (min)')
ylabel('N�vel (m)')

figure(5)
subplot(3,1,1)
hold on
plot(t,30*tanh(.65*LAB./(LAA+.01))+100)
title('Temperatura de Topo')
xlabel('Tempo (min)')
ylabel('Temperatura (�C)')
subplot(3,1,2)
hold on
plot(t,50*tanh(.75*LAB./(LAA+.01))+150)
title('Temperatura do Meio')
xlabel('Tempo (min)')
ylabel('Temperatura (�C)')
subplot(3,1,3)
hold on
plot(t,100*tanh(1.2*LDB./(LDA+.01))+200)
title('Temperatura de Fundo')
xlabel('Tempo (min)')
ylabel('Temperatura (�C)')


%---------------------------- SIMULA��ES ----------------------------------

function[LAA,LDA] = SIM1(F,AP,R,V,P,LAA,LDA)
[t,x]= ode45(@(t,LAA) .035*(tanh(09*AP(1)*(V(1)/R(1))-.0005*F(1)-.2*P)*F(1)*AP(1) -LAA),[0:.5:1],LAA(end));
LAA=[LAA x(end)];
[t,x]= ode45(@(t,LDA) .015*((1-(tanh(09*AP(1)*(V(1)/R(1))-.0005*F(1)-.2*P)))*F(1)*AP(1) -LDA),[0:.5:1],LDA(end));
LDA=[LDA x(end)];
end

function[LAB,LDB] = SIM2(F,BP,R,V,P,LAB,LDB)
[t,x]= ode45(@(t,LAB) .1*(tanh(11*BP(1)*(V(1)/R(1))-.03*F(1)-.01*P)*F(1)*BP(1) -LAB),[0:.5:1],LAB(end));
LAB=[LAB x(end)];
[t,x]= ode45(@(t,LDB) .08*((1-tanh(11*BP(1)*(V(1)/R(1))-.03*F(1)-.01*P))*F(1)*BP(1) -LDB),[0:.5:1],LDB(end));
LDB=[LDB x(end)];
end

function[NVT,NVF] = SIM3(LAA,LDA,LAB,LDB,NVT,NVF,R)
[t,x]= ode45(@(t,NVT) 20*(LAA(end)+LAB(end)) - R(1) -50*NVT(end) +10*NVT,[0:.5:1],NVT(end));
NVT=[NVT x(end)];

[t,x]= ode45(@(t,NVF) LDA(end)+LDB(end) - 10*NVF(end) +2*NVF,[0:.5:1],NVF(end));
NVF=[NVF x(end)];
end

% %--------------------------------------------------------------------------