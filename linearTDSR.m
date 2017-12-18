function results = linearTDSR(X,r,opto)
    
    % Linear TD-SR algorithm
    %
    % USAGE: results = linearTDSR(X,r,opto)
    %
    % INPUTS:
    %   X - [N x D] stimulus sequence (N = # trials, D = # features)
    %   r - [N x 1] reward sequence
    %   opto (optional) - sequence of optogenetic perturbations (default: all zeros)
    %
    % OUTPUTS:
    %   results - [N x 1] structure with the following fields:
    %               .R - reward estimate
    %               .V - value estimate
    %               .dt - prediction error
    %               .W - weight matrix
    %
    % Sam Gershman, Dec 2017
    
    [N,D] = size(X);
    X = [X; zeros(1,D)];    % add buffer at the end
    W = zeros(D);
    u = zeros(D,1);
    
    alpha_W = 0.2;
    alpha_u = 0.1;
    gamma = 0.95;
    if nargin < 3; opto = zeros(N,1); end
    E = zeros(1,D);
    lambda = 0.8;
    
    for n = 1:N
        E = lambda*E + X(n,:);
        dt = X(n,:) + (gamma*X(n+1,:) - X(n,:))*W + opto(n)*E;
        
        % store results
        results(n).R = X(n,:)*u;
        results(n).V = X(n,:)*W*u;
        results(n).dt = dt;
        results(n).W = W;
        
        % update
        W = W + alpha_W*X(n,:)'*dt;
        u = u + alpha_u*X(n,:)'*(r(n)-results(n).R);
    end