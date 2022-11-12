clear all
clc

%------------------ Desenvolvido por Filipe Pacheco ---------------------

P1 = 03;			% Press�o de coluna de suc��o - N/m�
P2 = 5.1214;	    % Press�o de descarga da bomba - N/m�
P3 = 01;            % Press�o do final do header  - N/m�
Cv1= 0100;			% �rea de suc��o da bomba - m�	
Cv2= 0070;			% �rea de descarga da bomba - m�
Ro =1000;			% Densidade do flu�do - kg/m�	

QE=Cv2*sqrt((P2(end)-P3)/Ro);

for i=1:10000
%     if i>25
%         P1=0;
%     end
    Qe       = Cv2*sqrt((P2(end)-P3)/Ro);
    QE(i+1)  = Qe;
    
    P2        = SIM1(P1,P2,P3,Cv1,Cv2);
end

plot(0:1:i,P2)
hold on
%plot(0:1:i,100*QE)

function[P2] = SIM1(P1,P2,P3,Cv1,Cv2)
[t,x]= ode15s(@(t,P2) Cv1^2*P1 -Cv2^2*P3  -Cv2^2*P2,[0:.5:1],P2(end));
P2=[P2 x(end)];
end