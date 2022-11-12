%----------------------------- Indentificação -----------------------------

%XYZ Space - 2 ações e 3 estados
%Autor: Filipe Pacheco (2020)

%--------------------------------------------------------------------------

%--------------------- Parâmetros do Sistema de Espaço --------------------

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

%--------------- Parâmetros de Inicialização do Controlador ---------------

%rng(3);                           % Seed fixa para random
REF  = [10 10 10]/10;                % Referência a ser alcançada - [X Y Z]
%REF(1) =randi([0 20],1);          % Gera REF aleatória para X
%REF(2) =randi([0 20],1);          % Gera REF aletaória para Y
%REF(3) =randi([0 20],1);          % Gera REF aleatória para Z
REFF = REF;                       % Armazena REF no vetor de REFF

DT  = 9;                          % Tempo de hiato do controlador - s
B   = zeros(1,9);                 % Vetor para armazenar a quanto tempo uma ação não é escolhida
N   = 5;

V1   = randi([-10 10],1)/10;      % Inicia a ação de controle 1 de modo aleatório
V2   = randi([-10 10],1)/10;      % Inicia a ação de controle 2 de modo aleatório
AUX4 = [V1 V2];

S1=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudança no estado 1 de modo aleatório
S2=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudança no estado 2 de modo aleatório
S3=randi([1 10],1,9)/1000;        % Inicia os efeitos de mudança no estado 3 de modo aleatório

%--------------------------------------------------------------------------

%------------------------ Simulação em minutos ----------------------------

for t=1:100
    if rem(t,500) == 0                                                      % Altera a REF(1),(2) e (3) aleatoriamente a cada ___ minutos
        REF(1) =randi([0 20],1);
        REF(2) =randi([0 20],1);
        REF(3) =randi([0 20],1);
    end
    REFF(t+1,1:3) = REF;
    
    if t> 10                
       if rem(t,DT) == 0                                                    % Executa a política de controle a cada (DT) minutos
            [AUX4,S1,S2,S3,B,N] = APR(REF,S1,S2,S3,X,Y,Z,V1,V2,B,N);        % Executa a política de controle
        end
    end
    
    BB(t) = mean(B);                                                        % Variável apenas para controle pessoal
    [X,Y,Z] = SIM1(X,Y,Z,V1,V2,g,m);                                        % Executa a EDO
       
    V1(t+1) = 2*AUX4(1);                                                    % Modificação da ação de controle 1 
    V2(t+1) = 2*AUX4(2);                                                    % Modificação da ação de controle 2       

% Alteração de parâmetros do sistema, a fim de verificar a adaptação do controlador    
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

%-------------------- Geração dos Gráficos de Análise  --------------------
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
% %title('Reator semi-batelada com Aquecimento - Variáveis de Processo')
% hold on
% %plot(0:1:t,CBB,'LineWidth',2,'Color','b')
% plot(0:1:t-20,REFF(21:t+1,1),'Color','k','LineWidth',4,'LineStyle','--')
% xlabel('Tempo (min)')
% ylabel('Concentração (mol/m³)')
% axis ([0 inf 0 1])
% legend('CB','REF')
% %legend('ESDI','ECDI','REF')
% subplot(2,1,2)
% plot(0:1:t-20,T(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,TT,'LineWidth',2,'Color','b')
% plot(0:1:t-20,REFF(21:t+1,2),'Color','k','LineWidth',4,'LineStyle','--')
% xlabel('Tempo (min)')
% ylabel('Temperatura (ºC)')
% axis ([0 inf 100 200])
% legend('To','REF')
% %legend('ESDI','ECDI','REF')

% figure (2)
% subplot(2,1,1)
% plot(0:1:t-20,Qe(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,QQE,'LineWidth',2,'Color','b')
% %legend('? - .01','? - .1')
% %title('Reator semi-batelada com Aquecimento - Variáveis Manipulada')
% xlabel('Tempo (min)')
% ylabel('Vazão de entrada (m³/min)')
% axis ([0 inf 0 2])
% subplot(2,1,2)
% plot(0:1:t-20,Qh(21:end),'LineWidth',3);%,'Color','r')
% hold on
% %plot(0:1:t,QHh,'LineWidth',2,'Color','b')
% %legend('? - .01','? - .1')
% xlabel('Tempo (min)')
% ylabel('Vazão de aquecimento (m³/min)')
% axis ([0 inf 0 2])

% figure (3)
% subplot(3,1,1)
% plot(0:1:t,Ce,'LineWidth',2,'Color','r')
% %title('Reator semi-batelada com Aquecimento - Variáveis Independentes')
% hold on
% xlabel('Tempo (min)')
% ylabel('Concentração de Entrada (mol/m³)')
% axis ([0 inf 0 2])
% subplot(3,1,2)
% plot(0:1:t,Te,'LineWidth',2,'Color','r')
% hold on
% xlabel('Tempo (min)')
% ylabel('Temp. da carga (ºC)')
% axis ([0 inf 30 50])
% subplot(3,1,3)
% plot(0:1:t,Th,'LineWidth',2,'Color','r')
% hold on
% xlabel('Tempo (min)')
% ylabel('Temp. do fluido de aquecimento (ºC)')
% axis ([0 inf 180 220])

EG = sum((REFF-[X; Y; Z;]').^2');
figure (4)
semilogy(0:1:t,EG,'LineWidth',3)
axis([0 inf 0 100])
hold on
xlabel('Tempo (min)')
ylabel('Erro Global - %')

%--------------------------------------------------------------------------

%---------------------- Resolução Númerica das EDOs  ----------------------

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

%----------------- APR - Objetivo Alcançar as Referências -----------------

function[AUX4,S1,S2,S3,B,N] = APR(REF,S1,S2,S3,X,Y,Z,V1,V2,B,N)
REF = REF/200;                                                               % Normalização das REF
X  = X/200;%*(1+randi([-300 300],1)/10000);                                  % Normalização de X - Com possibilidade de add ruído - ± 3% 
Y  = Y/200;%*(1+randi([-300 300],1)/10000);                                  % Normalização de Y - Com possibilidade de add ruído - ± 3%
Z  = Z/200;%*(1+randi([-300 300],1)/10000);                                  % Normalização de Y - Com possibilidade de add ruído - ± 3%
EG  = (REF-[X(end) Y(end) Z(end)])*(REF-[X(end) Y(end) Z(end)])';           % Erro Global
Eps = .15;                                                                  % Valor de Épsilon para Política Épsilon-Greedy - 15%
Q = zeros(1,9);                                                             % Inicia os valores da Q-function
Gamma = .1;                                                                 % Valor de desconto para as recompensas futuras
                                                  
DT  = 9;                                                                    % Tempo de hiato do controlador - min
I   = min(.01,max(10*EG));                                                  % Tamanho do incremento/decremento da ação de controle - limitado e prop. ao EG
A   = [1+I 1+I;1+I 1;1+I 1-I;1 1+I;1 1;1 1-I;1-I 1+I;1-I 1;1-I 1-I];        % Conjunto de Ações possíveis - 3^n - n = número de ações de controle

S1(size(S1,1)+1,N) = X(end-0)-X(end-DT);                                    % Atribui o efeito da modificação dos estados a ação que a executou
S2(size(S2,1)+1,N) = Y(end-0)-Y(end-DT);                                    % Atribui o efeito da modificação dos estados a ação que a executou
S3(size(S2,1)+1,N) = Z(end-0)-Z(end-DT);                                    % Atribui o efeito da modificação dos estados a ação que a executou

B = B +1;                                                                   % Aumenta indicação de tempo da ação de controle não selecionada
B(N) = 0;                                                                   % Zera o tempo da ação de controle que foi selecionada

for i=1:9                                                                   % Seleciona o último efeito de mudança nos estados para cada conj. de ação
    AUX = nonzeros(S1(:,i));
    DS1(i) = AUX(end);
    AUX = nonzeros(S2(:,i));
    DS2(i) = AUX(end);
    AUX = nonzeros(S3(:,i));
    DS3(i) = AUX(end);
end

for i=1:1:20                                                                % Calcula o valor da Q-function - E//[RWD(t)+gamma*RWD(t+1)...]
    RWD = (1-sum(((REF)'-[X(end); Y(end); Z(end)]-i*[DS1; DS2; DS3]).^2));  % Calcula o valor da Recompensa seguindo a mesma política de controle
    Q = Q + (Gamma^(i-1))*RWD;                                                
end

if randi([1 100],1) > 100*Eps                                               % Política Épsilon-Greedy - Decide entre melhor ação e valor aleatório  
    for i=1:9
        if max(Q(:)) == (Q(i))                                              % Seleciona melhor valor - Q*(max)
            n=i;
        end
    end
else                                                                        % Escolhe valor de ação aleatória - com maior peso nas não selecionadas há muito tempo
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
AUX4 = min(1,max(-1,((A(n,:)-1) +[V1(end) V2(end)])));                     % Incremento/decremento final nas ações de controle
end

%--------------------------------------------------------------------------