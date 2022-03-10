% Value Iteration algorithm

% G...cost matrix (states x inputs)
% P...probability matrix (states x states x inputs)
% V,V_new...cost to go
% V_i...cost to go at state i
% K...cardinality of the state space
% L...cardinality of the input space
% epsilon...threshold
% note that the terminal state is excluded here

V = inf(K,1);
V_new = zeros(K,1);
V_i = zeros(L,1);

while norm((V-V_new), inf) > epsilon
    V = V_new;
    for i = 1 : K
        for u = 1 : L
        	V_i(u) = G(i,u) + P(i,:,u)*V; 
        end
        V_new(i) = min(V_i);
    end
end
V_star = V_new;

% after finding the optimal cost to go, find the associated policy

u_star = zeros(K,1);

for i = 1 : K
    V_i_current = G(i,1) + P(i,:,1)*V_star;
    u_star(i) = 1;
    for u = 2 : L
        V_i_new = G(i,u) + P(i,:,u)*V_star;
        if V_i_new < V_i_current
            V_i_current = V_i_new;
            u_star(i) = u;
        end
    end
end
