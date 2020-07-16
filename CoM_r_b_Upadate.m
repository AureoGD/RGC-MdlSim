function [X_CoM] = CoM_r_b_Upadate(q)

persistent mi_1 mi_2 mi_3 mi_b base_CoM

if isempty(mi_1)
    mi_1 = 3.49/80.51;
    mi_2 = 4.95/80.51;
    mi_3 = 1.71/80.51;
    mi_b = 39.71/80.51;
    
    base_CoM = [1 0 0 0.060663;
        0 1 0 0.000598;
        0 0 1 -0.7592e-2;
        0 0 0 1];
end

[LF_HAA_CoM,RF_HAA_CoM, LH_HAA_CoM, RH_HAA_CoM, LF_HFE_CoM, RF_HFE_CoM, LH_HFE_CoM, RH_HFE_CoM, LF_KFE_CoM, RF_KFE_CoM, LH_KFE_CoM, RH_KFE_CoM] = HTCoMUpdate(q);

X_CoM = mi_b*base_CoM(1:3,4)+mi_1*(LF_HAA_CoM(1:3,4)+RF_HAA_CoM(1:3,4)+LH_HAA_CoM(1:3,4)+RH_HAA_CoM(1:3,4))+mi_2*(LF_HFE_CoM(1:3,4)+RF_HFE_CoM(1:3,4)+LH_HFE_CoM(1:3,4)+RH_HFE_CoM(1:3,4))+mi_3*(LF_KFE_CoM(1:3,4)+RF_KFE_CoM(1:3,4)+LH_KFE_CoM(1:3,4)+RH_KFE_CoM(1:3,4));







