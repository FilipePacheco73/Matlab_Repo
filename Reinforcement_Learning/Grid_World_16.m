clear all
clc

%------------------ Desenvolvido por Filipe Pacheco -----------------------

% Reinforcement Learning - Grid World - 1 x 6

%--------------------------------------------------------------------------

%-------------------------- Variáveis -------------------------------------

Rew = [-10 -1 -1 -1 -1 10];  % Recompensas durante a transição de estados

V   = [0 0 0 0 0 0];

Gamma = .5;

%--------------------------------------------------------------------------

%------------------------------- Value Interation--------------------------

% É possível escolher permanecer no estado atual

for i=1:1:20 
    
Vt(1) = max([Rew(1) + Gamma*V(1), Rew(2) + Gamma*V(2)]);

Vt(2) = max([Rew(1) + Gamma*V(1), Rew(2) + Gamma*V(2), Rew(3) + Gamma*V(3)]);

Vt(3) = max([Rew(2) + Gamma*V(2), Rew(3) + Gamma*V(3), Rew(4) + Gamma*V(4)]);

Vt(4) = max([Rew(3) + Gamma*V(3), Rew(4) + Gamma*V(4), Rew(5) + Gamma*V(5)]);

Vt(5) = max([Rew(4) + Gamma*V(4), Rew(5) + Gamma*V(5), Rew(6) + Gamma*V(6)]);

Vt(6) = max([Rew(5) + Gamma*V(5), Rew(6) + Gamma*V(6)]);

V = Vt;

figure(1)

heatmap(V)

pause(1)
end

%--------------------------------------------------------------------------

%------------------------------- Value Interation--------------------------

% Não é possível escolher permanecer no estado atual

% for i=1:1:20 
%     
% Vt(1) = max([Rew(2) + Gamma*V(2)]);
% 
% Vt(2) = max([Rew(1) + Gamma*V(1), Rew(3) + Gamma*V(3)]);
% 
% Vt(3) = max([Rew(2) + Gamma*V(2), Rew(4) + Gamma*V(4)]);
% 
% Vt(4) = max([Rew(3) + Gamma*V(3), Rew(5) + Gamma*V(5)]);
% 
% Vt(5) = max([Rew(4) + Gamma*V(4), Rew(6) + Gamma*V(6)]);
% 
% Vt(6) = max([Rew(5) + Gamma*V(5)]);
% 
% V = Vt;
% 
% figure(1)
% 
% heatmap(V)
% 
% pause(1)
% end

%--------------------------------------------------------------------------