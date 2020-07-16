function [H, Phi_q, G_q, K_tau, P_tau, K_force, P_force, inv_Jc] = UpdateModel1(q, e)

global M N ts Qq Qdw Kp Kd M_total 

persistent C Cf

if isempty(C)
    C =  [zeros(12,4) eye(12) zeros(12,12)];
         
    cf = [1 0 -0.9;
        -1 0 -0.9;
        0 1 -0.9;
        0 -1 -0.9;
        0 0 1;
        0 0 -1];
    Cf = blkdiag(cf, cf, cf, cf);
end

% constants update
[J_foot_LF, J_foot_RF, J_foot_LH, J_foot_RH] = JacobiansUpdate(q);
[J_CoM_LF, J_CoM_RF, J_CoM_LH, J_CoM_RH] = CoMJacobianUpdate(q);

R = RotMtxUpdate(e);
iJ = pinv([R*(J_CoM_LF-0.25*J_foot_LF) R*(J_CoM_RF-0.25*J_foot_RF) R*(J_CoM_LH-0.25*J_foot_LH)  R*(J_CoM_RH-0.25*J_foot_RH)]);
J_cont = [R'*inv(J_foot_LF)', R'*inv(J_foot_RF)', R'*inv(J_foot_LH)', R'*inv(J_foot_RH)'];


% predict model update
A = [J_cont*iJ*Kd/M_total [0;0;1] J_cont*Kp/M_total;...
    zeros(1,16);...
    iJ zeros(12,13)];

B = 1/M_total*[-J_cont*Kp;...
               zeros(13,12)];
           
Ad = eye(16)+ts*A;
Bd = ts*B;

A_ext = [Ad Bd; zeros(12,16) eye(12)];
B_ext = [Bd; eye(12)];

%Max&Min tau constraints
L = [-Kd*iJ zeros(12,1) -Kp*eye(12) Kp*eye(12)];

% Force constraints
inv_Jc = blkdiag(R'*inv(J_foot_LF)', R'*inv(J_foot_RF)', R'*inv(J_foot_LH)', R'*inv(J_foot_RH)');
FC_mtx = Cf*inv_Jc;

for i = 1:N
    for j=1:M
        if j <= i
            G_q(i*12-11:i*12, j*12-11:j*12) = C*A_ext^(i-j)*B_ext;
            if i == j
               K_tau(i*12-11:i*12, j*12-11:j*12) = Kp*eye(12); 
            else
               K_tau(i*12-11:i*12, j*12-11:j*12) = L*A_ext^(i-j-1)*B_ext;
            end
            K_force(i*24-23:i*24, j*12-11:j*12)= FC_mtx*K_tau(i*12-11:i*12, j*12-11:j*12);
        end
    end
end


for i=1:N
    Phi_q(i*12-11:i*12,:) = C*A_ext^(i);
    P_tau(i*12-11:i*12,:) = L*A_ext^(i-1);
    P_force(i*24-23:i*24,:) = FC_mtx*P_tau(i*12-11:i*12,:);
end

H = G_q'*Qq*G_q+Qdw; 


end