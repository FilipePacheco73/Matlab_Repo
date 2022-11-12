clear all
clc

%------------------ Desenvolvido por Filipe Pacheco ---------------------

P  = 12;			% Pressão a jusante da válvula - N/m²
P1 = 20;			% Pressão Inicial do Header	- N/m²
P2 = 01;			% Pressão ao final do Header de escoamento - N/m²
Cv1= 0100;			% Área inicial de escoamento - m²	
Cv2= 51.32;			% Área de restrição da válvula - m²
Ro =1000;			% Densidade do fluído	- kg/m³	

QE=Cv2*sqrt((P(end)-P2)/Ro);

for i=1:50
    if i>25
        Cv2=1.75;
    end
    Qe       = Cv2*sqrt((P(end)-P2)/Ro);
    QE(i+1)  = Qe;
    
    P        = SIM1(P,P1,P2,Cv1,Cv2);
end

plot(0:1:i,P)
hold on
plot(0:1:i,100*QE)

function[P] = SIM1(P,P1,P2,Cv1,Cv2)
[t,h]= ode45(@(t,P) Cv1^2*P1 + Cv2^2*P2 -(Cv1^2+Cv2^2)*P,[0:.5:1],P(end));
P=[P h(end)];
end