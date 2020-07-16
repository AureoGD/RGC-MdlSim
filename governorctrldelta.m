function w = governorctrldelta(in)
global N Qe Qw Qq options k tau_max tau_min pred_tau pred_q pred_force force_cons Exit_flag states force_ft time

persistent delta

if isempty(delta)
    delta = [];
    for i=1:N
        delta = vertcat(delta,[2.5;2.5;5;2.5;2.5;5;2.5;2.5;5;2.5;2.5;5]);
    end
    
end
if in(44)>= 1
    X = in(1:16);
    
    Ref = [];
    for i =1:N
        Ref = [Ref; in(17:28)];
    end
    
    w_ant = in(29:40);
    
    e = in(41:43);
    
    % [H, Phi_w, G_w, Phi_e, G_e, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel1(X(5:16));
    
    st = [X; w_ant];

    
    % Fnc custo 1
%     [H, Phi_q, G_q, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel1(X(5:16), e);
%     F = 2* double(((Phi_q*st-Ref)'*Qq*G_q));
%     
    % Fnc custo 1
%     [H, Phi_w, G_w, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel2(X(5:16), e);
%     F = 2* double(((Phi_w*st-Ref)'*Qw*G_w));
%     
%     Fcn custo 2
    [H, Phi_w, G_w, Phi_q, G_q, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel4(X(5:16), e);
    F = 2* double(((Phi_w*st-Ref)'*Qw*G_w) + ((Phi_q*st-Ref)'*Qq*G_q)); 
    
%     Fnc custo 3
%     [H, Phi_w, G_w, Phi_e, G_e, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel3(X(5:16), e);
%     F = 2* double(((Phi_w*st-Ref)'*Qw*G_w) + ((Phi_e*st)'*Qe*G_e));

%     max&min tau constraint
% 
    A_in = [K_tau; -K_tau;-K_force];
    b_in = [tau_max-P_tau*st;...
        -tau_min+P_tau*st;...
        P_force*st-force_cons];

% if in(44) <=2.5
%     A_in = [K_tau; -K_tau;-K_force];
%     b_in = [tau_max-P_tau*st;...
%         -tau_min+P_tau*st;...
%         P_force*st-force_cons];
% else
%     A_in = [K_tau; -K_tau];
%     b_in = [tau_max-P_tau*st;...
%         -tau_min+P_tau*st];
%     
% end
% 
%     A_in = -K_force;
%     b_in = P_force*st-force_cons;
% 
%     A_in = [K_tau; -K_tau];
%     b_in = [tau_max-P_tau*st;...
%         -tau_min+P_tau*st];
% %     
    tic;
%     dW = quadprog(2*H, F', [], [],[],[],[],[],[],options);
    [dW, faval, exit_flag, OUTPUT, LAMBDA] = quadprog(2*H, F', A_in, b_in, [], [],[],[],[],options);
  time(k)= toc;
    
    if exit_flag == -2
        dW = zeros(12,1);
    end
%     
%     Exit_flag(:,k) = exit_flag;
%     
%     states(:,k) = [st;e];
    pred_tau(:,k) = K_tau(1:12,1:12)*dW(1:12)+P_tau(1:12,:)*st;
%     force_ft(:,k) = -inv_Jc*pred_tau(:,k);
%     pred_force(:,k) = -inv_Jc*(K_tau(1:12,1:12)*dW(1:12)+P_tau(1:12,:)*st);
%     pred_force(:,k) = -K_force(1:24,1:12)*dW(1:12)-P_force(1:24,:)*st+force_cons(1:24,:);
%     pred_q(:,k) = G_q(1:12,1:12)*dW(1:12)+Phi_q(1:12,:)*st;
else
    dW = zeros(12,1);
end
k = k+1;
w =dW(1:12);    