clc
clear all
close all

global M N ts Qe Qw Qdw Qq options Kp Kd M_total g k tau_max tau_min pred_tau pred_q Kp_mtx Kd_mtx pred_force force_cons Exit_flag states force_ft time

Exit_flag = [];
pred_tau = [];
pred_q = [];
pred_force = [];
force_ft = [];
states = [];
k = 0;
time = [];

%initial conditions
stiffnes = 3e4;
g = -9.81;
M_total = 80.51;

q0 = [-0.05, 1.3, -2.65,-0.05, 1.3, -2.65, -0.05, -1.3, 2.65, -0.05, -1.3, 2.65]';
% qr = [ -0.05, 0.9, -2.3, -0.05, 0.9, -2.3, -0.05, -0.9, 2.3, -0.05, -0.9, 2.3]';
qr = [ -0.082, 0.65, -1.18, -0.082, 0.65, -1.18, -0.082, -0.65, 1.18, -0.082, -0.65, 1.18]';
q0 = qr;

[LF_foot, RF_foot, LH_foot, RH_foot, LF_HAA, RF_HAA, LH_HAA, RH_HAA, LF_HFE, RF_HFE, LH_HFE, RH_HFE, LF_KFE, RF_KFE, LH_KFE, RH_KFE] = HTUpdate(q0);
[J_foot_LF, J_foot_RF, J_foot_LH, J_foot_RH] = JacobiansUpdate(q0);

J = blkdiag(J_foot_LF, J_foot_RF, J_foot_LH, J_foot_RH);

x0 = [0;0;-LF_foot(3,4)]; %base initial position
x0(3) = x0(3)+0.02;
r0 = x0+CoM_r_b_Upadate(q0); %CoM initial position

% sample time
ts = 0.005;

% PD parameters

Kp = 300; % 300
Kd = 10; % 10
N_f = 20;

Kp_mtx = Kp*eye(12);
Kd_mtx = Kd*eye(12);

% MPC parameters

N = 8;
M = 3;
Qe = 0.01* eye(12*N); % 0.05
Qw = 0.10 * eye(12*N); %0.3
Qq = 0.025 * eye(12*N);
Qdw = 160 * eye(12*M);

% Qw = 0.15 * eye(12*N); %0.3
% Qq = 2.5 * eye(12*N);

options = optimset('Display', 'off', 'MaxIter',500);

tau_max = 100*ones(N*12,1);
tau_min = -tau_max;
fz_max = 450;
fz_min = 50; % valor 

force_cons = [];

for i=1:N*4
   force_cons = vertcat(force_cons, [0;0;0;0; -fz_max; fz_min]); 
end

