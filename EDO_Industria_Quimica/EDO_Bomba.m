clear all
clc

%------------------ Desenvolvido por Filipe Pacheco ---------------------

P1 = 03;			% Pressão de coluna de sucção - N/m²
P2 = 5.1214;	    % Pressão de descarga da bomba - N/m²
P3 = 01;            % Pressão do final do header  - N/m²
Cv1= 0100;			% Área de sucção da bomba - m²	
Cv2= 0070;			% Área de descarga da bomba - m²
Ro =1000;			% Densidade do fluído - kg/m³	

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