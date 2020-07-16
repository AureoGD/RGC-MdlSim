function [H, Phi_w, G_w, Phi_e, G_e, K_tau, P_tau, K_tau_v, P_tau_v, b_v, inv_Jc] = UpdateModel5(q)

global M N ts Qe Qw Qdw Kp Kd M_total tau_sim

persistent C Cf Ce

if isempty(C)
    C =  [zeros(12,16) eye(12)];
         
    cf = [1 0 -0.2;
        -1 0 -0.2;
        0 1 -0.2;
        0 -1 -0.2;
        0 0 1;
        0 0 -1];
    Cf = blkdiag(cf, cf, cf, cf);
    
    Ce = [zeros(12,4) -eye(12) eye(12)];
    
    tau_sim = zeros(12,12);
    tau_sim(1,2) = 1;
    tau_sim(1,5) = -1;
    tau_sim(2,8) = 1;
    tau_sim(2,11)=-1;
    tau_sim(3,2) = 1;
    tau_sim(3,11) = -1;

    tau_sim(4,3) = 1;
    tau_sim(4,6) = -1;
    tau_sim(5,8) = 1;
    tau_sim(5,12)=-1;
    tau_sim(6,3) = 1;
    tau_sim(6,12) = -1;
    
    tau_sim(7,2) = -1;
    tau_sim(7,5) = 1;    
    tau_sim(8,8) =-1;
    tau_sim(8,11) =1;
    tau_sim(9,2) = 1;
    tau_sim(9,11) = -1;
    
    tau_sim(10,2) = -1;
    tau_sim(10,5) = 1;    
    tau_sim(11,8) =-1;
    tau_sim(11,11) =1;
    tau_sim(12,2) = 1;
    tau_sim(12,11) = -1;
end

% constants update
[J_foot_LF, J_foot_RF, J_foot_LH, J_foot_RH] = JacobiansUpdate(q);
[J_CoM_LF, J_CoM_RF, J_CoM_LH, J_CoM_RH] = CoMJacobianUpdate(q);

J_cont = [inv(J_foot_LF)', inv(J_foot_RF)', inv(J_foot_LH)', inv(J_foot_RH)'];
iJ = pinv([(J_CoM_LF-0.25*J_foot_LF) (J_CoM_RF-0.25*J_foot_RF) (J_CoM_LH-0.25*J_foot_LH) (J_CoM_RH-0.25*J_foot_RH)]);



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
inv_Jc = blkdiag(inv(J_foot_LF)', inv(J_foot_RF)', inv(J_foot_LH)', inv(J_foot_RH)');
FC_mtx = Cf*inv_Jc;

% max&min torque time variant
[A, b] = TauMaxMin(q);

% P1 = Polyhedron( 'A', -A(1:6,:), 'b',-b(1:6));
% P1.plot;
% 
% P1 = Polyhedron( 'A', -A(7:12,:), 'b',-b(7:12));
% P1.plot;
% 
% P1 = Polyhedron( 'A', -A(13:18,:), 'b',-b(13:18));
% P1.plot;
% 
% P1 = Polyhedron( 'A', -A(19:24,:), 'b',-b(19:24));
% P1.plot;

A_tau_mtx = blkdiag(A(1:6,:),A(7:12,:),A(13:18,:), A(19:24,:));

for i = 1:N
    for j=1:M
        if j <= i
            G_w(i*12-11:i*12, j*12-11:j*12) = C*A_ext^(i-j)*B_ext;
            G_e(i*12-11:i*12, j*12-11:j*12) = Ce*A_ext^(i-j)*B_ext;
            if i == j
               K_tau(i*12-11:i*12, j*12-11:j*12) = Kp*eye(12); 
            else
               K_tau(i*12-11:i*12, j*12-11:j*12) = L*A_ext^(i-j-1)*B_ext;
            end
            K_tau_eq(i*12-11:i*12, j*12-11:j*12) = tau_sim*K_tau(i*12-11:i*12, j*12-11:j*12);
            K_tau_v(i*24-23:i*24, j*12-11:j*12)= A_tau_mtx*K_tau(i*12-11:i*12, j*12-11:j*12);
        end
    end
end


for i=1:N
    Phi_w(i*12-11:i*12,:) = C*A_ext^(i);
    Phi_e(i*12-11:i*12,:) = Ce*A_ext^(i);
    P_tau(i*12-11:i*12,:) = L*A_ext^(i-1);
%     P_force(i*24-23:i*24,:) = FC_mtx*P_tau(i*12-11:i*12,:);
    P_tau_v(i*24-23:i*24,:) = A_tau_mtx*L*A_ext^(i-1);
    P_tau_eq(i*12-11:i*12,:) = tau_sim*L*A_ext^(i-1);
    b_v(i*24-23:i*24,:)= b; 
end

% H = G_w'*Qw*G_w+G_w'*Qe*G_w+Qdw; %J4
H = G_w'*Qw*G_w+Qdw; %J4


end