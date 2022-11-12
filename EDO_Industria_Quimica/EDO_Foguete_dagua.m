clear all
clc

%------------------ Desenvolvido por Filipe Pacheco -----------------------

P1  = 1.5; %Pascal - N/m�
P2  = 1.5; %Pascal - N/m�
V1  = 1e-3;  %Volume de ar - m�
V2  = 2e-3;  %Volume de �gua - m�
Cv  = .25*pi*(2e-2)^2; % m�
Row = 1000;  %kg/m�
Roa = 1.225;   %kg/m�

for i=1:1000   
    V2      = SIM1(P1,V1,V2,Cv,Row);
end

figure (1)
subplot(3,1,1)
plot(0:1:i,P2);
subplot(3,1,2)
plot(0:1:i,V1);
subplot(3,1,3)
plot(0:1:i,V2);

%--------------------------- EDO ------------------------------------------

function[V2] = SIM1(P1,V1,V2,Cv,Row)
[t,x]= ode15s(@(t,V2) .001*(-V2 +Cv*sqrt((V1(1)*P1)/(V2(end)*Row))),[0:.5:1],V2(end));
x= real(max(x,0));
V2=[V2 x(end)];
end