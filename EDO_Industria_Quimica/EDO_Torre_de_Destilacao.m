clear all
clc

%------------------ Desenvolvido por Filipe Pacheco ---------------------

Fi  =   10;      %Vazão de carga;
F   =   Fi;
APi =   .7;      %Composição de A na carga;
AP  =   APi;
BPi =   .3;      %Composição de B na carga;
BP  =   BPi;
Ri  =   20;      %Vazão de Refluxo;
R   =   Ri;
Vi  =   04;      %Vazão de vapor;
V   =   Vi;
P   =   01;      %Pressão de operação da coluna;
LAA =   01;      %Vazão de líquido ascendente - A
LAB =   00;      %Vazão de líquido ascendente - B
LDA =   01;      %Vazão de líquido descendente - A
LDB =   00;      %Vazão de líquido descendente - B
NVT =   02;      %Nível do vaso de topo;
NVF =   01;      %Nível de vaso de fundo;

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
    
[LAA,LDA]  = SIM1(F,AP,R,V,P,LAA,LDA);             %Vazão de líquido Ascendente e Descendente - A
[LAB,LDB]  = SIM2(F,BP,R,V,P,LAB,LDB);             %Vazão de líquido Ascendente e Descendente - B
[NVT,NVF]  = SIM3(LAA,LDA,LAB,LDB,NVT,NVF,R);      %Nível de topo e de fundo


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
title('Vazão de LAA')
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDA)
title('Vazão de LDA')
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')

figure(2)
subplot(2,1,1)
hold on
plot(t,LAB)
title('Vazão de LAB')
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDB)
title('Vazão de LDB')
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')

figure(3)
subplot(2,1,1)
hold on
plot(t,100*LAA./(LAA+LAB))
title('Concentração de A no topo')
xlabel('Tempo (min)')
ylabel('Concentração (%)')
subplot(2,1,2)
hold on
plot(t,100*LAB./(LAA+LAB))
title('Concentração de B no topo')
xlabel('Tempo (min)')
ylabel('Concentração (%)')

figure(4)
subplot(2,1,1)
hold on
plot(t,NVT)
title('Nível de Topo')
xlabel('Tempo (min)')
ylabel('Nível (m)')
subplot(2,1,2)
hold on
plot(t,NVF)
title('Nível de Fundo')
xlabel('Tempo (min)')
ylabel('Nível (m)')

figure(5)
subplot(3,1,1)
hold on
plot(t,30*tanh(.65*LAB./(LAA+.01))+100)
title('Temperatura de Topo')
xlabel('Tempo (min)')
ylabel('Temperatura (ºC)')
subplot(3,1,2)
hold on
plot(t,50*tanh(.75*LAB./(LAA+.01))+150)
title('Temperatura do Meio')
xlabel('Tempo (min)')
ylabel('Temperatura (ºC)')
subplot(3,1,3)
hold on
plot(t,100*tanh(1.2*LDB./(LDA+.01))+200)
title('Temperatura de Fundo')
xlabel('Tempo (min)')
ylabel('Temperatura (ºC)')


%---------------------------- SIMULAÇÕES ----------------------------------

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