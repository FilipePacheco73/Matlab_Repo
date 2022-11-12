clear all
clc

%------------------ Desenvolvido por Filipe Pacheco -----------------------

% Reinforcement Learning - Grid World - 1 x 6

%--------------------------------------------------------------------------

%-------------------------- Variáveis -------------------------------------

n= 11;

Size = n*n;

Rew = -1*ones(n);  % Recompensas durante a transição de estados;

Rew(6,6) = 10; % Goal - Objetivo

V   = zeros(n);  % Valor do estado inicial;

Gamma = .5; % Fator de desconto;

%--------------------------------------------------------------------------

%------------------------------- Value Interation--------------------------

% É possível escolher permanecer no estado atual

for k=1:1:30
    for i=1:1:n
        for j=1:1:n
            if i > 1 && j > 1 && i < n && j < n
                Vt(1) = [Rew(i,j-1) + Gamma*V(i,j-1)];
                Vt(2) = [Rew(i,j+1) + Gamma*V(i,j+1)];
                Vt(3) = [Rew(i-1,j) + Gamma*V(i-1,j)];
                Vt(4) = [Rew(i+1,j) + Gamma*V(i+1,j)];
                Vt(5) = [Rew(i,j) + Gamma*V(i,j)];
                V(i,j) = max(Vt);
            end
            
            if i == 1 && j > 1 && j < n
                Vt(1) = [Rew(i,j-1) + Gamma*V(i,j-1)];
                Vt(2) = [Rew(i,j+1) + Gamma*V(i,j+1)];
                Vt(3) = [Rew(i+1,j) + Gamma*V(i+1,j)];
                Vt(4) = [Rew(i,j) + Gamma*V(i,j)];
                V(i,j) = max(Vt(1:4));
            end
            
            if i == n && j > 1 && j < n
                Vt(1) = [Rew(i,j-1) + Gamma*V(i,j-1)];
                Vt(2) = [Rew(i,j+1) + Gamma*V(i,j+1)];
                Vt(3) = [Rew(i-1,j) + Gamma*V(i-1,j)];
                Vt(4) = [Rew(i,j) + Gamma*V(i,j)];
                V(i,j) = max(Vt(1:4));
            end
            
            if j == 1 && i > 1 && i < n
                Vt(1) = [Rew(i+1,j) + Gamma*V(i+1,j)];
                Vt(2) = [Rew(i-1,j) + Gamma*V(i-1,j)];
                Vt(3) = [Rew(i,j+1) + Gamma*V(i,j+1)];
                Vt(4) = [Rew(i,j) + Gamma*V(i,j)];
                V(i,j) = max(Vt(1:4));
            end
            
            if j == n && i > 1 && i < n
                Vt(1) = [Rew(i+1,j) + Gamma*V(i+1,j)];
                Vt(2) = [Rew(i-1,j) + Gamma*V(i-1,j)];
                Vt(3) = [Rew(i,j-1) + Gamma*V(i,j-1)];
                Vt(4) = [Rew(i,j) + Gamma*V(i,j)];
                V(i,j) = max(Vt(1:4));
            end
            
            V(1,1) = max([Rew(1,1) + Gamma*V(1,1), Rew(1,2) + Gamma*V(1,2), Rew(2,1) + Gamma*V(2,1)]);
            V(1,n) = max([Rew(1,n) + Gamma*V(1,n), Rew(1,9) + Gamma*V(1,n-1), Rew(2,n) + Gamma*V(2,n)]);
            V(n,1) = max([Rew(n,1) + Gamma*V(n,1), Rew(n-1,1) + Gamma*V(n-1,1), Rew(n,2) + Gamma*V(n,2)]);
            V(n,n) = max([Rew(n,n) + Gamma*V(n,n), Rew(n,n-1) + Gamma*V(n,n-1), Rew(n-1,n) + Gamma*V(n-1,n)]);
        end
    end
    
    figure(1)
    
    heatmap(V)
    
    pause(1)
end

%--------------------------------------------------------------------------

        