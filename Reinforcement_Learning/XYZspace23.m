%----------------------------- Indentifica��o -----------------------------

%XYZ Space - 2 a��es e 3 estados
%Autor: Filipe Pacheco (2020)

%--------------------------------------------------------------------------

%--------------------- Par�metros do Sistema de Espa�o --------------------

clc
clear all

g   = 9.7833;
m   = 5;
V1  = 0;
V2  = 0;
X   = 0;
Y   = 0;
Z   = 0;

%--------------------------------------------------------------------------

%--------------- Par�metros de Inicializa��o do Controlador ---------------

%rng(3);                           % Seed fixa para random
REF  = [10 10 10]/10;                % Refer�ncia a ser alcan�ada - [X Y Z]
%REF(1) =randi([0 20],1);          % Gera REF aleat�ria para X
%REF(2) =randi([0 20],1);          % Gera REF aleta�ria para Y
%REF(3) =randi([0 20],1);          % Gera REF aleat�ria para Z
REFF = REF;                       % Armazena REF no vetor de REFF

DT  = 9;                          % Tempo de hiato do controlador - s
B   = zeros(1,9);                 % Vetor para armazenar a quanto tempo uma a��o n�o � escolhida
N   = 5;

V1   = randi([-10 10],1)/10;      % Inicia a a��o de controle 1 de modo aleat�rio
V2   = randi([-10 10],1)/10;      % Inicia a a��o de controle 2 de modo aleat�rio
AUX4 = [V1 V2];

S1=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudan�a no estado 1 de modo aleat�rio
S2=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudan�a no estado 2 de modo aleat�rio
S3=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudan�a no estado 3 de modo aleat�rio

%--------------------------------------------------------------------------

%------------------------ Simula��o em minutos ----------------------------

for t=1:100
    if rem(t,500) == 0                                                      % Altera a REF(1),(2) e (3) aleatoriamente a cada ___ minutos
        REF(1) =randi([0 20],1);
        REF(2) =randi([0 20],1);
        REF(3) =randi([0 20],1);
    end
    REFF(t+1,1:3) = REF;
    
    if t> 10                
       if rem(t,DT) == 0                                                    % Executa a pol�tica de controle a cada (DT) minutos
            [AUX4,S1,S2,S3,B,N] = APR(REF,S1,S2,S3,X,Y,Z,V1,V2,B,N);        % Executa a pol�tica de controle
        end
    end
    
    BB(t) = mean(B);                                                        % Vari�vel apenas para controle pessoal
    [X,Y,Z] = SIM1(X,Y,Z,V1,V2,g,m);                                        % Executa a EDO
       
    V1(t+1) = 2*AUX4(1);                                                    % Modifica��o da a��o de controle 1 
    V2(t+1) = 2*AUX4(2);                                                    % Modifica��o da a��o de controle 2       

% Altera��o de par�metros do sistema, a fim de verificar a adapta��o do controlador    
%
%     if rem(t,15000) == 0
%         Ce(t+1) = 1*(1+randi([-10 10],1)/100);
%     else
%         Ce(t+1) = Ce(end);
%     end
%     if rem(t,20000) == 0
%         Te(t+1) = 40*(1+randi([-10 10],1)/100);
%     else
%         Te(t+1) = Te(end);
%     end
%     if rem(t,25000) == 0
%         Th(t+1) = 200*(1+randi([-10 10],1)/100);
%     else
%         Th(t+1) = Th(end);
%     end
    
end

%--------------------------------------------------------------------------

%-------------------- Gera��o dos Gr�ficos de An�lise  --------------------
figure (1)
plot3(X,Y,Z)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(REF(1),REF(2),REF(3),'o','LineWidth',5')
grid on
% subplot(2,1,1)
% plot(0:1:t-20,CB(21:end),'LineWidth',3);%,'Color','r')
% %title('Reator semi-batelada com Aquecimento - Vari�veis de Processo')
% hold on
% %plot(0:1:t,CBB,'LineWidth',2,'Color','b')
% plot(0:1:t-20,REFF(21:t+1,1),'Color','k','LineWidth',4,'LineStyle','--')
% xlabel('Tempo (min)')
% ylabel('Concentra��o (mol/m�)')
% axis ([0 inf 0 1])
% legend('CB','REF')
% %legend('ESDI','ECDI','REF')
% subplot(2,1,2)
% plot(0:1:t-20,T(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,TT,'LineWidth',2,'Color','b')
% plot(0:1:t-20,REFF(21:t+1,2),'Color','k','LineWidth',4,'LineStyle','--')
% xlabel('Tempo (min)')
% ylabel('Temperatura (�C)')
% axis ([0 inf 100 200])
% legend('To','REF')
% %legend('ESDI','ECDI','REF')

% figure (2)
% subplot(2,1,1)
% plot(0:1:t-20,Qe(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,QQE,'LineWidth',2,'Color','b')
% %legend('? - .01','? - .1')
% %title('Reator semi-batelada com Aquecimento - Vari�veis Manipulada')
% xlabel('Tempo (min)')
% ylabel('Vaz�o de entrada (m�/min)')
% axis ([0 inf 0 2])
% subplot(2,1,2)
% plot(0:1:t-20,Qh(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,QHh,'LineWidth',2,'Color','b')
% %legend('? - .01','? - .1')
% xlabel('Tempo (min)')
% ylabel('Vaz�o de aquecimento (m�/min)')
% axis ([0 inf 0 2])

% figure (3)
% subplot(3,1,1)
% plot(0:1:t,Ce,'LineWidth',2,'Color','r')
% %title('Reator semi-batelada com Aquecimento - Vari�veis Independentes')
% hold on
% xlabel('Tempo (min)')
% ylabel('Concentra��o de Entrada (mol/m�)')
% axis ([0 inf 0 2])
% subplot(3,1,2)
% plot(0:1:t,Te,'LineWidth',2,'Color','r')
% hold on
% xlabel('Tempo (min)')
% ylabel('Temp. da carga (�C)')
% axis ([0 inf 30 50])
% subplot(3,1,3)
% plot(0:1:t,Th,'LineWidth',2,'Color','r')
% hold on
% xlabel('Tempo (min)')
% ylabel('Temp. do fluido de aquecimento (�C)')
% axis ([0 inf 180 220])

EG = sum((REFF-[X; Y; Z;]').^2');
figure (4)
semilogy(0:1:t,EG,'LineWidth',3)
axis([0 inf 0 100])
hold on
xlabel('Tempo (min)')
ylabel('Erro Global - %')

%--------------------------------------------------------------------------

%---------------------- Resolu��o N�merica das EDOs  ----------------------

function[X,Y,Z] = SIM1(X,Y,Z,V1,V2,g,m)
%[~,x]= ode45(@(t,CA) (Qe(end)*Ce(end)-Cv(end)*sqrt(g*H(end))*CA-2*Ab*H(end)*Ko*exp(-E/(R*(T(end)+273.15)))*CA)/(Ab*H(end)) ,(0:.5:1),CA(end));
[~,x]= ode45(@(t,X) (cos(V1(end)-V2(end)) -(.05*m*(V1(end)-V2(end)))^2), (0:.5:1),X(end));
[~,y]= ode45(@(t,Y) (sin(V2(end)-V1(end)) -(.05*m*(V2(end)+V1(end)))^2), (0:.5:1),Y(end));
[~,z]= ode45(@(t,Z) (10*(V1(end)+V2(end))/m -g*Z(end)),                     (0:.5:1),Z(end));

X=[X x(end)];
Y=[Y y(end)];
Z=[Z z(end)];
end

%--------------------------------------------------------------------------

%----------------- APR - Objetivo Alcan�ar as Refer�ncias -----------------

function[AUX4,S1,S2,S3,B,N] = APR(REF,S1,S2,S3,X,Y,Z,V1,V2,B,N)
REF = REF/200;                                                               % Normaliza��o das REF
X  = X/200;%*(1+randi([-300 300],1)/10000);                                  % Normaliza��o de X - Com possibilidade de add ru�do - � 3% 
Y  = Y/200;%*(1+randi([-300 300],1)/10000);                                  % Normaliza��o de Y - Com possibilidade de add ru�do - � 3%
Z  = Z/200;%*(1+randi([-300 300],1)/10000);                                  % Normaliza��o de Y - Com possibilidade de add ru�do - � 3%
EG  = (REF-[X(end) Y(end) Z(end)])*(REF-[X(end) Y(end) Z(end)])';           % Erro Global
Eps = .15;                                                                  % Valor de �psilon para Pol�tica �psilon-Greedy - 15%
Q = zeros(1,9);                                                             % Inicia os valores da Q-function
Gamma = .1;                                                                 % Valor de desconto para as recompensas futuras
                                                  
DT  = 9;                                                                    % Tempo de hiato do controlador - min
I   = min(.01,max(10*EG));                                                  % Tamanho do incremento/decremento da a��o de controle - limitado e prop. ao EG
A   = [1+I 1+I;1+I 1;1+I 1-I;1 1+I;1 1;1 1-I;1-I 1+I;1-I 1;1-I 1-I];        % Conjunto de A��es poss�veis - 3^n - n = n�mero de a��es de controle

S1(size(S1,1)+1,N) = X(end-0)-X(end-DT);                                    % Atribui o efeito da modifica��o dos estados a a��o que a executou
S2(size(S2,1)+1,N) = Y(end-0)-Y(end-DT);                                    % Atribui o efeito da modifica��o dos estados a a��o que a executou
S3(size(S2,1)+1,N) = Z(end-0)-Z(end-DT);                                    % Atribui o efeito da modifica��o dos estados a a��o que a executou

B = B +1;                                                                   % Aumenta indica��o de tempo da a��o de controle n�o selecionada
B(N) = 0;                                                                   % Zera o tempo da a��o de controle que foi selecionada

for i=1:9                                                                   % Seleciona o �ltimo efeito de mudan�a nos estados para cada conj. de a��o
    AUX = nonzeros(S1(:,i));
    DS1(i) = AUX(end);
    AUX = nonzeros(S2(:,i));
    DS2(i) = AUX(end);
    AUX = nonzeros(S3(:,i));
    DS3(i) = AUX(end);
end

for i=1:1:20                                                                % Calcula o valor da Q-function - E//[RWD(t)+gamma*RWD(t+1)...]
    RWD = (1-sum(((REF)'-[X(end); Y(end); Z(end)]-i*[DS1; DS2; DS3]).^2));  % Calcula o valor da Recompensa seguindo a mesma pol�tica de controle
    Q = Q + (Gamma^(i-1))*RWD;                                                
end

if randi([1 100],1) > 100*Eps                                               % Pol�tica �psilon-Greedy - Decide entre melhor a��o e valor aleat�rio  
    for i=1:9
        if max(Q(:)) == (Q(i))                                              % Seleciona melhor valor - Q*(max)
            n=i;
        end
    end
else                                                                        % Escolhe valor de a��o aleat�ria - com maior peso nas n�o selecionadas h� muito tempo
    C = (100*B/sum(B));
    D = sort(C);
    for i=1:1:9
        E(i) = sum(D(1:i));
    end
    R = randi([1 99],1);
    i=1;
    while i < 10 && E(i) <= R
        m = i+1;
        i = i+1;
    end
    for i=1:9 
        if  round(C(i),3) == round(E(m)-E(m-1),3)
            n = i;
        end
    end
end
N   = n;
AUX4 = min(1,max(-1,((A(n,:)-1) +[V1(end) V2(end)])));                     % Incremento/decremento final nas a��es de controle
end

%--------------------------------------------------------------------------