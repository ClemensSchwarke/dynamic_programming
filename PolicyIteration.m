% Policy Iteration algorithm

% G...cost matrix (states x inputs)
% Q...cost vector, given policy mu (states)
% P...probability matrix (states x states x inputs)
% Pr...probability matrix, given policy mu (states x states)
% Mu,Mu_new...policy
% V_mu...cost to go, given policy mu
% V_i...cost to go at state i
% V_star...optimal cost to go
% K...cardinality of the state space
% L...cardinality of the input space
% note that the terminal state is excluded here

Mu = zeros(K,1);
Mu_new = zeros(K,1);
Pr = zeros(K);
Q = zeros(K,1);

while true
    for i = 1 : K
        Pr(i,:) = P(i,:,Mu(i));
        Q(i) = G(i,Mu(i));
    end
    V_mu = pinv(eye(K) - Pr) * Q;
    
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
