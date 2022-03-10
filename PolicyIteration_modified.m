% Policy Iteration algorithm (modified)

% G...cost matrix (states x inputs)
% Q...cost vector, given policy mu (states)
% P...probability matrix (states x states x inputs)
% Pr...probability matrix, given policy mu (states x states)
% Mu,Mu_new...policy
% V_mu,V_mu_new...cost to go, given policy mu
% V_i...cost to go at state i
% V_star...optimal cost to go
% K...cardinality of the state space
% L...cardinality of the input space
% epsilon...threshold
% note that the terminal state is excluded here

V_mu = inf(K,1);
V_mu_new = zeros(K,1);
Mu = zeros(K,1);
Mu_new = zeros(K,1);
Pr = zeros(K);
Q = zeros(K,1);

while true
    while norm((V_mu-V_mu_new), inf) > epsilon
        V_mu = V_mu_new;
        for i = 1 : K
            V_mu_new(i) = G(i,Mu(i)) + P(i,:,Mu(i))*V_mu; 
        end
    end
    
    for i = 1 : K
        V_i_current = G(i,1) + P(i,:,1)*V_mu;
        Mu_new(i) = 1;
        for u = 2 : L
            V_i_new = G(i,u) + P(i,:,u)*V_mu;
            if V_i_new < V_i_current
                V_i_current = V_i_new;
                Mu_new(i) = u;
            end
        end
    end
    if Mu == Mu_new
        break;
    else
        Mu = Mu_new;
    end
end
V_star = V_mu;
u_star = Mu;
