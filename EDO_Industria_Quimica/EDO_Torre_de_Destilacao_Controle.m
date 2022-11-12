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
LAA =   5.4691;      %Vazão de líquido ascendente - A
LAB =   1.0012;      %Vazão de líquido ascendente - B
LDA =   1.5351;      %Vazão de líquido descendente - A
LDB =   1.9987;      %Vazão de líquido descendente - B
NVT =   05;          %Nível do vaso de topo;
NVF =   05;          %Nível de vaso de fundo;

P   =   01;         %Pressão de operação da coluna;
CvP =   47.4;       %Área de escoamento da pressão;

CvP1 = 500;         %Área de sucção da P-101;
CvP2 = 400;         %Área de descarga da P-101;
PP1  = NVT(end);    %NPSH da P-101;
PP2  = 33.1780;     %Pressão de descarga da P-101;
PP3  = P;           %Pressão a montante de Válvula;

CvP3 = 200;         %Área de sucção da P-102;
CvP4 = 100;         %Área de descarga da P-102;
PP4  = NVF(end);    %NPSH da P-102;
PP5  = 33.1780;     %Pressão de descarga da P-102;
PP6  = 01;          %Pressão a montante de Válvula;

Ro   =  999;        %Peso específico do fluído destilado;
Cv11 =  300;        %Área de escoamento FC-1 - Montante;
Cv12 =  3*24.91;    %Área de escoamento FC-1 - Válvula;
P11  =  020;        %Pressão de escoamento FC-1 - Montante;
P12  =  18.872;     %Pressão de escoamento FC-1 - Válvula;
P13  =  P;          %Pressão de escoamento FC-1 - Torre;

Cv21 =  400;        %Área de escoamento FC-2 - Montante;
Cv22 =  4*28.9270;  %Área de escoamento FC-2 - Válvula;
P21  =  PP2;        %Pressão de escoamento FC-2 - Montante;
P22  =  33.3452;    %Pressão de escoamento FC-2 - Válvula;
P23  =  P;          %Pressão de escoamento FC-2 - Torre;

Cv31 =  200;        %Área de escoamento FC-3 - Montante;
Cv32 =  2*17.1142;  %Área de escoamento FC-2 - Válvula;
P31  =  PP2;        %Pressão de escoamento FC-3 - P-101;
P32  =  32;         %Pressão de escoamento FC-3 - Válvula;
P33  =  001;        %Pressão de escoamento FC-3 - Header final - A;

Cv41 =  100;        %Área de escoamento FC-4 - Montante;
Cv42 =  50;         %Área de escoamento FC-4 - Válvula;
P41  =  020;        %Pressão de escoamento FC-4 - Header distribuidor;
P42  =  16.8347;    %Pressão de escoamento FC-4 - Válvula;
P43  =  005;        %Pressão de escoamento FC-4 - Header coletor;

Cv51 =  100;        %Área de escoamento FC-5 - Montante;
Cv52 =  19.68;      %Área de escoamento FC-5 - Válvula;
P51  =  PP5;        %Pressão de escoamento FC-5 - P-102;
P52  =  31.9907;    %Pressão de escoamento FC-5 - Válvula;
P53  =  001;        %Pressão de escoamento FC-5 - Header final - B;

Erro = [0 0 0 0 0 0 0 0 0];
dErro= [0 0 0 0 0 0 0 0 0];

PB1  = 500;
TI1  = 500;
TD1  = 000;
PB2  = 300;
TI2  = 300;
TD2  = 000;
PB3  = 900;
TI3  = 600;
TD3  = 000;
PB4  = 300;
TI4  = 300;
TD4  = 000;
PB5  = 500;
TI5  = 600;
TD5  = 020;
PB6  = 500;
TI6  = 400;
TD6  = 000;
PB7  = 999;
TI7  = 999;
TD7  = 050;
PB8  = 999;
TI8  = 400;
TD8  = 000;

PB9  = 999;
TI9  = 400;
TD9  = 000;

MV1  = Cv12/3;
MV2  = Cv22/4;
MV3  = Cv32/2;
MV4  = Cv42;
MV5  = 059.7;
MV6  = Cv52;
MV7  = 35;
MV8  = 40;
MV9  = CvP;

MV   =[MV1 MV2 MV3 MV4 MV5 MV6 MV7 MV8 MV9];
PB   =[PB1 PB2 PB3 PB4 PB5 PB6 PB7 PB8 PB9];
TI   =[TI1 TI2 TI3 TI4 TI5 TI6 TI7 TI8 TI9];
TD   =[TD1 TD2 TD3 TD4 TD5 TD6 TD7 TD8 TD9];

Q1  = Cv12*sqrt((P12(end)-P13)/Ro);
Q2  = Cv22*sqrt((P22(end)-P23)/Ro);
Q3  = Cv32*sqrt((P32(end)-P33)/Ro);
Q4  = Cv42*sqrt((P42(end)-P43)/(2*Ro));
Q5  = Cv52*sqrt((P52(end)-P53)/(Ro));


for i=1:09
    V=[V Vi];
end
for i=1:29
    R=[R Ri];
end
for i=1:19
    AP=[AP APi];
end
for i=1:19
    BP=[BP BPi];
end
for i=1:14
    F=[F Fi];
end

for i=1:200  
    
    [REF]      = [10 20 .1*MV(5) .1*MV(8) 5 .1*MV(7) 5 156 1];
        
    [LAA,LDA]  = SIM1(F,AP,R,V,P,LAA,LDA);             %Vazão de líquido Ascendente e Descendente - A
    [LAB,LDB]  = SIM2(F,BP,R,V,P,LAB,LDB);             %Vazão de líquido Ascendente e Descendente - B
    [NVT,NVF]  = SIM3(LAA,LDA,LAB,LDB,NVT,NVF,Q3,Q5);  %Nível de topo e de fundo
    [P12]      = SIM4(P12,P11,P13,Cv11,Cv12);          %Vazão de escoamento na carga
    [P22]      = SIM5(P22,P21,P23,Cv21,Cv22);          %Vazão de escoamento no Refluxo
    [P32]      = SIM6(P32,P31,P33,Cv31,Cv32);          %Vazão de vapor
    [P42]      = SIM7(P42,P41,P43,Cv41,Cv42);          %Vazão de escoamento na retirada de topo
    [P52]      = SIM8(P52,P51,P53,Cv51,Cv52);          %Vazão de escoamento na retirada de fundo
    [P]        = SIM9(P,LAA,LAB,CvP);                  %Pressão da coluna
    [PP2]      = SIM10(PP1,PP2,PP3,CvP1,CvP2);         %Vazão da P-101;
    [PP5]      = SIM11(PP4,PP5,PP6,CvP3,CvP4);         %Vazão da P-102;        
        
    Q1  = Cv12*sqrt((P12(end)-P13)/Ro);
    Q2  = Cv22*sqrt((P22(end)-P23)/Ro);
    Q3  = Cv32*sqrt((P32(end)-P33)/Ro);
    Q4  = Cv42*sqrt((P42(end)-P43)/(2*Ro));
    Q5  = Cv52*sqrt((P52(end)-P53)/(Ro));
    
    P13 = P(end);
    P23 = P(end);
    PP1 = NVT(end);
    PP4 = NVF(end);
    PP3 = P(end);
    P21 = PP2(end);
    P31 = PP2(end);
    
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
    
    SUM = (MV./(100./PB) + Erro - TD.*dErro)./(1./TI);                  % Cálculo para troca de Manual para Auto
    SUM = min(TI.*(PB-Erro- TD.*dErro), max(TI.*(-Erro-TD.*dErro),SUM));% Limitação máxima e mínima do SUM.
    
    dErro = ((REF-[Q1 Q2 Q3 Q4 NVT(end) Q5 NVF(end) 50*tanh(.75*LAB(end)./(LAA(end)+.01))+150 P(end)]) - Erro)*[.5 0 0 0 0 0 0 0 0; 0 .3 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0;0 0 0 1 0 0 0 0 0;0 0 0 0 -1 0 0 0 0;0 0 0 0 0 1 0 0 0;0 0 0 0 0 0 -1 0 0; 0 0 0 0 0 0 0 .05 0;0 0 0 0 0 0 0 0 -10];       % Cálculo da Variação do Erro
    Erro  = (REF-[Q1 Q2 Q3 Q4 NVT(end) Q5 NVF(end) 50*tanh(.75*LAB(end)./(LAA(end)+.01))+150 P(end)])*[5 0 0 0 0 0 0 0 0; 0 3.3 0 0 0 0 0 0 0; 0 0 10 0 0 0 0 0 0; 0 0 0 10 0 0 0 0 0; 0 0 0 0 -10 0 0 0 0; 0 0 0 0 0 10 0 0 0; 0 0 0 0 0 0 -10 0 0; 0 0 0 0 0 0 0 .5 0; 0 0 0 0 0 0 0 0 -100];                    % Cálculo do Erro
    SUM   = SUM + Erro;                                                 % Cálculo do Controlador PID - Integral
    
    MV    = (100./PB).*(Erro +(1./TI).*SUM +TD.*dErro);                 % Cálculo do Controlador PID - Soma das Três partes
    MV    = min(100, max(0.0001,MV));                                   % Limitação máxima e mínima das MV.
    
    Cv12 = 3*MV(1);
    Cv22 = 4*MV(2);
    Cv32 = 2*MV(3);
    Cv42 = 1*MV(4);
    Cv52 = 1*MV(6);
    CvP  = 1*MV(9);
            
    F   = [F(2:size(F,2)) Q1];
    V   = [V(2:size(V,2)) Q4];
    R   = [R(2:size(F,2)) Q2];
    AP  = [AP(2:size(AP,2)) APi];
    BP  = [BP(2:size(BP,2)) BPi];
end
t=0:1:i;

figure(1)
subplot(2,1,1)
hold on
plot(t,LAA)
title('Vazão de LAA')
ylim([0 10])
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDA)
title('Vazão de LDA')
ylim([0 10])
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')

figure(2)
subplot(2,1,1)
hold on
plot(t,LAB)
title('Vazão de LAB')
ylim([0 10])
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')
subplot(2,1,2)
hold on
plot(t,LDB)
title('Vazão de LDB')
ylim([0 10])
xlabel('Tempo (min)')
ylabel('Vazão (ton/h)')

figure(3)
subplot(2,1,1)
hold on
plot(t,100*LAA./(LAA+LAB))
title('Concentração de A no topo')
ylim([50 100])
xlabel('Tempo (min)')
ylabel('Concentração (%)')
subplot(2,1,2)
hold on
plot(t,100*LAB./(LAA+LAB))
ylim([0 50])
title('Concentração de B no topo')
xlabel('Tempo (min)')
ylabel('Concentração (%)')

figure(4)
subplot(2,1,1)
hold on
plot(t,NVT)
ylim([0 10])
title('Nível de Topo')
xlabel('Tempo (min)')
ylabel('Nível (m)')
subplot(2,1,2)
hold on
plot(t,NVF)
ylim([0 10])
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
% 
% plot(NVF(1:end-1))
% hold on
% %plot(RR)
% plot(RT*.1)


%---------------------------- SIMULAÇÕES ----------------------------------

function[LAA,LDA] = SIM1(F,AP,R,V,P,LAA,LDA)
[t,x]= ode15s(@(t,LAA) .035*(tanh(09*AP(1)*(V(1)/R(1))-.0005*F(1)-.2*P(end))*F(1)*AP(1) -LAA),[0:.5:1],LAA(end));
LAA=[LAA x(end)];
[t,x]= ode15s(@(t,LDA) .015*((1-(tanh(09*AP(1)*(V(1)/R(1))-.0005*F(1)-.2*P(end))))*F(1)*AP(1) -LDA),[0:.5:1],LDA(end));
LDA=[LDA x(end)];
end

function[LAB,LDB] = SIM2(F,BP,R,V,P,LAB,LDB)
[t,x]= ode15s(@(t,LAB) .1*(tanh(11*BP(1)*(V(1)/R(1))-.03*F(1)-.01*P(end))*F(1)*BP(1) -LAB),[0:.5:1],LAB(end));
LAB=[LAB x(end)];
[t,x]= ode45(@(t,LDB) .08*((1-tanh(11*BP(1)*(V(1)/R(1))-.03*F(1)-.01*P(end)))*F(1)*BP(1) -LDB),[0:.5:1],LDB(end));
LDB=[LDB x(end)];
end

function[NVT,NVF] = SIM3(LAA,LDA,LAB,LDB,NVT,NVF,Q3,Q5)
[t,x]= ode15s(@(t,NVT) .05*((LAA(end)+LAB(end)) -1*Q3),[0:.5:1],NVT(end));
NVT=[NVT x(end)];

[t,x]= ode15s(@(t,NVF) .05*(LDA(end)+LDB(end) - Q5),[0:.5:1],NVF(end));
NVF=[NVF x(end)];
end

function[P12] = SIM4(P12,P11,P13,Cv11,Cv12)
[t,x]= ode15s(@(t,P12) Cv11^2*P11 + Cv12^2*P13 -(Cv11^2+Cv12^2)*P12,[0:.5:1],P12(end));
P12=[P12 x(end)];
end

function[P22] = SIM5(P22,P21,P23,Cv21,Cv22)
[t,x]= ode15s(@(t,P22) Cv21^2*P21 + Cv22^2*P23 -(Cv21^2+Cv22^2)*P22,[0:.5:1],P22(end));
P22=[P22 x(end)];
end

function[P32] = SIM6(P32,P31,P33,Cv31,Cv32)
[t,x]= ode15s(@(t,P32) Cv31^2*P31 + Cv32^2*P33 -(Cv31^2+Cv32^2)*P32,[0:.5:1],P32(end));
P32=[P32 x(end)];
end

function[P42] = SIM7(P42,P41,P43,Cv41,Cv42)
[t,x]= ode15s(@(t,P42) Cv41^2*P41 + Cv42^2*P43 -(Cv41^2+Cv42^2)*P42,[0:.5:1],P42(end));
P42=[P42 x(end)];
end

function[P52] = SIM8(P52,P51,P53,Cv51,Cv52)
[t,x]= ode15s(@(t,P52) Cv51^2*P51 + Cv52^2*P53 -(Cv51^2+Cv52^2)*P52,[0:.5:1],P52(end));
P52=[P52 x(end)];
end

function[P] = SIM9(P,LAA,LAB,CvP)
[t,x]= ode15s(@(t,P) .1*(8*(LAA(end)+LAB(end)) -CvP*P),[0:.5:1],P(end));
P=[P x(end)];
end

function[PP2] = SIM10(PP1,PP2,PP3,CvP1,CvP2)
[t,x]= ode15s(@(t,PP2) (CvP1^2*7*3+10e1*PP1) -.5*CvP2^2*PP3  -CvP2^2*PP2,[0:.5:1],PP2(end));
if PP1<.01
    x = 0;
end
PP2=[PP2 x(end)];
end

function[PP5] = SIM11(PP4,PP5,PP6,CvP3,CvP4)
[t,x]= ode15s(@(t,PP5) (CvP3^2*4*3+10e0*PP4) -20*CvP4^2*PP6  -CvP4^2*PP5,[0:.5:1],PP5(end));
if PP4<.01
    x = 0;
end
PP5=[PP5 x(end)];
end
%--------------------------------------------------------------------------