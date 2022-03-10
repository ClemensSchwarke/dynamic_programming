% Value Iteration algorithm (Gauss Seidel)

% G...cost matrix (states x inputs)
% P...probability matrix (states x states x inputs)
% V...cost to go
% V_i...cost to go at state i
% K...cardinality of the state space
% L...cardinality of the input space
% err...error
% epsilon...threshold
% note that the terminal state is excluded here

V = zeros(K,1);
err = inf;

while err > epsilon
    err = 0;
    for i = 1 : K
        V_i_current = G(i,1) + P(i,:,1)*V;
        for u = 2 : L
            V_i_new = G(i,u) + P(i,:,u)*V;
            if V_i_new < V_i_current
                V_i_current = V_i_new;
            end
        end
        if V_i_current > 0
            err = max(err,abs((V_i_current - V(i)) / V_i_current));
        end
        V(i) = V_i_current;
    end
end
V_star = V;

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
