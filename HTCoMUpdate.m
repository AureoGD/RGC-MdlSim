function [LF_HAA_CoM,RF_HAA_CoM, LH_HAA_CoM, RH_HAA_CoM, LF_HFE_CoM, RF_HFE_CoM, LH_HFE_CoM, RH_HFE_CoM, LF_KFE_CoM, RF_KFE_CoM, LH_KFE_CoM, RH_KFE_CoM] = HTCoMUpdate(q)

persistent HT_LF_HAA_CoM HT_RF_HAA_CoM HT_LH_HAA_CoM HT_RH_HAA_CoM HT_LF_HFE_CoM HT_RF_HFE_CoM HT_LH_HFE_CoM HT_RH_HFE_CoM HT_LF_KFE_CoM HT_RF_KFE_CoM HT_LH_KFE_CoM HT_RH_KFE_CoM

if isempty(HT_LF_HAA_CoM)
    
    HT_LF_HAA_CoM = zeros(4);
    HT_RF_HAA_CoM = zeros(4);
    HT_LH_HAA_CoM = zeros(4);
    HT_RH_HAA_CoM = zeros(4);
    
    HT_LF_HFE_CoM = zeros(4);
    HT_RF_HFE_CoM = zeros(4);
    HT_LH_HFE_CoM = zeros(4);
    HT_RH_HFE_CoM = zeros(4);
    
    HT_LF_KFE_CoM = zeros(4);
    HT_RF_KFE_CoM = zeros(4);
    HT_LH_KFE_CoM = zeros(4);
    HT_RH_KFE_CoM = zeros(4);
    
    HT_LF_HAA_CoM(4,4) = 0.1e1;
    HT_RF_HAA_CoM(4,4) = 0.1e1;
    HT_LH_HAA_CoM(4,4) = 0.1e1;
    HT_RH_HAA_CoM(4,4) = 0.1e1;
    
    HT_LF_HFE_CoM(4,4) = 0.1e1;
    HT_RF_HFE_CoM(4,4) = 0.1e1;
    HT_LH_HFE_CoM(4,4) = 0.1e1;
    HT_RH_HFE_CoM(4,4) = 0.1e1;
    
    HT_LF_KFE_CoM(4,4) = 0.1e1;
    HT_RF_KFE_CoM(4,4) = 0.1e1;
    HT_LH_KFE_CoM(4,4) = 0.1e1;
    HT_RH_KFE_CoM(4,4) = 0.1e1;
    
    HT_LF_HAA_CoM(1,3) = -0.1e1;
    HT_RF_HAA_CoM(1,3) = 0.1e1;
    HT_LH_HAA_CoM(1,3) = -0.1e1;
    HT_RH_HAA_CoM(1,3) = 0.1e1;
    
    HT_LF_HAA_CoM(1,4) = 0.4433040000e0;
    HT_RF_HAA_CoM(1,4) = 0.4436960000e0;
    HT_LH_HAA_CoM(1,4) = -0.443304000000000031e0;
    HT_RH_HAA_CoM(1,4) = -0.443695999999999979e0;
      
end

% HAA

HT_LF_HAA_CoM(2,1) = -0.1e1 * sin(q(1));
HT_LF_HAA_CoM(2,2) = -0.1e1 * cos(q(1));
HT_LF_HAA_CoM(2,4) = 0.9700000000e-1 + 0.605e-3 * sin(q(1)) + 0.1346e-2 * cos(q(1));
HT_LF_HAA_CoM(3,1) = -cos(q(1));
HT_LF_HAA_CoM(3,2) = sin(q(1));
HT_LF_HAA_CoM(3,4) = 0.605e-3 * cos(q(1)) - 0.1346e-2 * sin(q(1));

HT_RF_HAA_CoM(2,1) = 0.1e1 * sin(q(4));
HT_RF_HAA_CoM(2,2) = 0.1e1 * cos(q(4));
HT_RF_HAA_CoM(2,4) = -0.9700000000e-1 - 0.605e-3 * sin(q(4)) - 0.1346e-2 * cos(q(4));
HT_RF_HAA_CoM(3,1) = -cos(q(4));
HT_RF_HAA_CoM(3,2) = sin(q(4));
HT_RF_HAA_CoM(3,4) = 0.605e-3 * cos(q(4)) - 0.1346e-2 * sin(q(4));

HT_LH_HAA_CoM(2,1) = -0.1e1 * sin(q(7));
HT_LH_HAA_CoM(2,2) = -0.1e1 * cos(q(7));
HT_LH_HAA_CoM(2,4) = 0.970000000000000029e-1 + 0.605e-3 * sin(q(7)) + cos(q(7)) * (-0.134599999999999997e-2);
HT_LH_HAA_CoM(3,1) = -cos(q(7));
HT_LH_HAA_CoM(3,2) = sin(q(7));
HT_LH_HAA_CoM(3,4) = 0.605e-3 * cos(q(7)) + sin(q(7)) * 0.134599999999999997e-2;

HT_RH_HAA_CoM(2,1) = 0.1e1 * sin(q(10));
HT_RH_HAA_CoM(2,2) = 0.1e1 * cos(q(10));
HT_RH_HAA_CoM(2,4) = -0.970000000000000029e-1 - 0.605e-3 * sin(q(10)) + cos(q(10)) * 0.134599999999999997e-2;
HT_RH_HAA_CoM(3,1) = -cos(q(10));
HT_RH_HAA_CoM(3,2) = sin(q(10));
HT_RH_HAA_CoM(3,4) = 0.605e-3 * cos(q(10)) + sin(q(10)) * 0.134599999999999997e-2;

%HFE
HT_LF_HFE_CoM(1,1) = -0.1e1 * sin(q(2));
HT_LF_HFE_CoM(1,2) = -0.1e1 * cos(q(2));
HT_LF_HFE_CoM(1,4) = 0.4435000000e0 - 0.144296e0 * sin(q(2)) + 0.2071e-2 * cos(q(2));
HT_LF_HFE_CoM(2,1) = -0.1e1 * sin(q(1)) * cos(q(2));
HT_LF_HFE_CoM(2,2) = 0.1e1 * sin(q(1)) * sin(q(2));
HT_LF_HFE_CoM(2,3) = 0.1e1 * cos(q(1));
HT_LF_HFE_CoM(2,4) = -0.144296e0 * sin(q(1)) * cos(q(2)) - 0.2071e-2 * sin(q(1)) * sin(q(2)) + 0.111906e0 * cos(q(1)) + 0.9700000000e-1;
HT_LF_HFE_CoM(3,1) = -cos(q(1)) * cos(q(2));
HT_LF_HFE_CoM(3,2) = cos(q(1)) * sin(q(2));
HT_LF_HFE_CoM(3,3) = -sin(q(1));
HT_LF_HFE_CoM(3,4) = -0.144296e0 * cos(q(1)) * cos(q(2)) - 0.2071e-2 * cos(q(1)) * sin(q(2)) - 0.111906e0 * sin(q(1));

HT_RF_HFE_CoM(1,1) = -0.1e1 * sin(q(5));
HT_RF_HFE_CoM(1,2) = -0.1e1 * cos(q(5));
HT_RF_HFE_CoM(1,4) = 0.4435000000e0 - 0.144296e0 * sin(q(5)) + 0.2071e-2 * cos(q(5));
HT_RF_HFE_CoM(2,1) = 0.1e1 * sin(q(4)) * cos(q(5));
HT_RF_HFE_CoM(2,2) = -0.1e1 * sin(q(4)) * sin(q(5));
HT_RF_HFE_CoM(2,3) = 0.1e1 * cos(q(4));
HT_RF_HFE_CoM(2,4) = 0.144296e0 * sin(q(4)) * cos(q(5)) + 0.2071e-2 * sin(q(4)) * sin(q(5)) - 0.122094e0 * cos(q(4)) - 0.9700000000e-1;
HT_RF_HFE_CoM(3,1) = -cos(q(4)) * cos(q(5));
HT_RF_HFE_CoM(3,2) = cos(q(4)) * sin(q(5));
HT_RF_HFE_CoM(3,3) = sin(q(4));
HT_RF_HFE_CoM(3,4) = -0.144296e0 * cos(q(4)) * cos(q(5)) - 0.2071e-2 * cos(q(4)) * sin(q(5)) - 0.122094e0 * sin(q(4));

HT_LH_HFE_CoM(1,1) = -0.1e1 * sin(q(8));
HT_LH_HFE_CoM(1,2) = -0.1e1 * cos(q(8));
HT_LH_HFE_CoM(1,4) = -0.443500000000000005e0 - 0.144296e0 * sin(q(8)) + cos(q(8)) * (-0.207099999999999992e-2);
HT_LH_HFE_CoM(2,1) = -0.1e1 * sin(q(7)) * cos(q(8));
HT_LH_HFE_CoM(2,2) = 0.1e1 * sin(q(7)) * sin(q(8));
HT_LH_HFE_CoM(2,3) = 0.1e1 * cos(q(7));
HT_LH_HFE_CoM(2,4) = -0.144296e0 * sin(q(7)) * cos(q(8)) + sin(q(7)) * sin(q(8)) * 0.207099999999999992e-2 + cos(q(7)) * 0.122094000000000008e0 + 0.9700000000e-1;
HT_LH_HFE_CoM(3,1) = -cos(q(7)) * cos(q(8));
HT_LH_HFE_CoM(3,2) = cos(q(7)) * sin(q(8));
HT_LH_HFE_CoM(3,3) = -sin(q(7));
HT_LH_HFE_CoM(3,4) = -0.144296e0 * cos(q(7)) * cos(q(8)) + cos(q(7)) * sin(q(8)) * 0.207099999999999992e-2 + sin(q(7)) * (-0.122094000000000008e0);

HT_RH_HFE_CoM(1,1) = -0.1e1 * sin(q(11));
HT_RH_HFE_CoM(1,2) = -0.1e1 * cos(q(11));
HT_RH_HFE_CoM(1,4) = -0.443500000000000005e0 - 0.144296e0 * sin(q(11)) + cos(q(11)) * (-0.207099999999999992e-2);
HT_RH_HFE_CoM(2,1) = 0.1e1 * sin(q(10)) * cos(q(11));
HT_RH_HFE_CoM(2,2) = -0.1e1 * sin(q(10)) * sin(q(11));
HT_RH_HFE_CoM(2,3) = 0.1e1 * cos(q(10));
HT_RH_HFE_CoM(2,4) = 0.144296e0 * sin(q(10)) * cos(q(11)) + sin(q(10)) * sin(q(11)) * (-0.207099999999999992e-2) + cos(q(10)) * (-0.111906000000000005e0) - 0.9700000000e-1;
HT_RH_HFE_CoM(3,1) = -cos(q(10)) * cos(q(11));
HT_RH_HFE_CoM(3,2) = cos(q(10)) * sin(q(11));
HT_RH_HFE_CoM(3,3) = sin(q(10));
HT_RH_HFE_CoM(3,4) = -0.144296e0 * cos(q(10)) * cos(q(11)) + cos(q(10)) * sin(q(11)) * 0.207099999999999992e-2 + sin(q(10)) * (-0.111906000000000005e0);

%KFE

HT_LF_KFE_CoM(1,1) = -0.1e1 * sin(q(2)) * cos(q(3)) - 0.1e1 * cos(q(2)) * sin(q(3));
HT_LF_KFE_CoM(1,2) = 0.1e1 * sin(q(2)) * sin(q(3)) - 0.1e1 * cos(q(2)) * cos(q(3));
HT_LF_KFE_CoM(1,4) = -0.109015e0 * sin(q(2)) * cos(q(3)) - 0.109015e0 * cos(q(2)) * sin(q(3)) + 0.42147e-1 * sin(q(2)) * sin(q(3)) - 0.42147e-1 * cos(q(2)) * cos(q(3)) + 0.4435000000e0 - 0.360e0 * sin(q(2));
HT_LF_KFE_CoM(2,1) = -0.1e1 * sin(q(1)) * cos(q(2)) * cos(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_KFE_CoM(2,2) = 0.1e1 * sin(q(1)) * cos(q(2)) * sin(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_KFE_CoM(2,3) = 0.1e1 * cos(q(1));
HT_LF_KFE_CoM(2,4) = -0.109015e0 * sin(q(1)) * cos(q(2)) * cos(q(3)) + 0.109015e0 * sin(q(1)) * sin(q(2)) * sin(q(3)) + 0.42147e-1 * sin(q(1)) * cos(q(2)) * sin(q(3)) + 0.42147e-1 * sin(q(1)) * sin(q(2)) * cos(q(3)) + 0.117219e0 * cos(q(1)) - 0.360e0 * sin(q(1)) * cos(q(2)) + 0.9700000000e-1;
HT_LF_KFE_CoM(3,1) = -cos(q(1)) * cos(q(2)) * cos(q(3)) + cos(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_KFE_CoM(3,2) = cos(q(1)) * cos(q(2)) * sin(q(3)) + cos(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_KFE_CoM(3,3) = -sin(q(1));
HT_LF_KFE_CoM(3,4) = -0.109015e0 * cos(q(1)) * cos(q(2)) * cos(q(3)) + 0.109015e0 * cos(q(1)) * sin(q(2)) * sin(q(3)) + 0.42147e-1 * cos(q(1)) * cos(q(2)) * sin(q(3)) + 0.42147e-1 * cos(q(1)) * sin(q(2)) * cos(q(3)) - 0.117219e0 * sin(q(1)) - 0.360e0 * cos(q(1)) * cos(q(2));

HT_RF_KFE_CoM(1,1) = -0.1e1 * sin(q(5)) * cos(q(6)) - 0.1e1 * cos(q(5)) * sin(q(6));
HT_RF_KFE_CoM(1,2) = 0.1e1 * sin(q(5)) * sin(q(6)) - 0.1e1 * cos(q(5)) * cos(q(6));
HT_RF_KFE_CoM(1,4) = -0.109015e0 * sin(q(5)) * cos(q(6)) - 0.109015e0 * cos(q(5)) * sin(q(6)) + 0.42147e-1 * sin(q(5)) * sin(q(6)) - 0.42147e-1 * cos(q(5)) * cos(q(6)) + 0.4435000000e0 - 0.360e0 * sin(q(5));
HT_RF_KFE_CoM(2,1) = 0.1e1 * sin(q(4)) * cos(q(5)) * cos(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_KFE_CoM(2,2) = -0.1e1 * sin(q(4)) * cos(q(5)) * sin(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_KFE_CoM(2,3) = 0.1e1 * cos(q(4));
HT_RF_KFE_CoM(2,4) = 0.109015e0 * sin(q(4)) * cos(q(5)) * cos(q(6)) - 0.109015e0 * sin(q(4)) * sin(q(5)) * sin(q(6)) - 0.42147e-1 * sin(q(4)) * cos(q(5)) * sin(q(6)) - 0.42147e-1 * sin(q(4)) * sin(q(5)) * cos(q(6)) - 0.116781e0 * cos(q(4)) + 0.360e0 * sin(q(4)) * cos(q(5)) - 0.9700000000e-1;
HT_RF_KFE_CoM(3,1) = -cos(q(4)) * cos(q(5)) * cos(q(6)) + cos(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_KFE_CoM(3,2) = cos(q(4)) * cos(q(5)) * sin(q(6)) + cos(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_KFE_CoM(3,3) = sin(q(4));
HT_RF_KFE_CoM(3,4) = -0.109015e0 * cos(q(4)) * cos(q(5)) * cos(q(6)) + 0.109015e0 * cos(q(4)) * sin(q(5)) * sin(q(6)) + 0.42147e-1 * cos(q(4)) * cos(q(5)) * sin(q(6)) + 0.42147e-1 * cos(q(4)) * sin(q(5)) * cos(q(6)) - 0.116781e0 * sin(q(4)) - 0.360e0 * cos(q(4)) * cos(q(5));

HT_LH_KFE_CoM(1,1) = -0.1e1 * sin(q(8)) * cos(q(9)) - 0.1e1 * cos(q(8)) * sin(q(9));
HT_LH_KFE_CoM(1,2) = 0.1e1 * sin(q(8)) * sin(q(9)) - 0.1e1 * cos(q(8)) * cos(q(9));
HT_LH_KFE_CoM(1,4) = -0.443500000000000005e0 - 0.109015e0 * sin(q(8)) * cos(q(9)) - 0.109015e0 * cos(q(8)) * sin(q(9)) + sin(q(8)) * sin(q(9)) * (-0.421469999999999970e-1) + cos(q(8)) * cos(q(9)) * 0.421469999999999970e-1 - 0.360e0 * sin(q(8));
HT_LH_KFE_CoM(2,1) = -0.1e1 * sin(q(7)) * cos(q(8)) * cos(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_KFE_CoM(2,2) = 0.1e1 * sin(q(7)) * cos(q(8)) * sin(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_KFE_CoM(2,3) = 0.1e1 * cos(q(7));
HT_LH_KFE_CoM(2,4) = -0.109015e0 * sin(q(7)) * cos(q(8)) * cos(q(9)) + 0.109015e0 * sin(q(7)) * sin(q(8)) * sin(q(9)) + sin(q(7)) * cos(q(8)) * sin(q(9)) * (-0.421469999999999970e-1) + sin(q(7)) * sin(q(8)) * cos(q(9)) * (-0.421469999999999970e-1) + cos(q(7)) * 0.116781000000000010e0 - 0.360e0 * sin(q(7)) * cos(q(8)) + 0.9700000000e-1;
HT_LH_KFE_CoM(3,1) = -cos(q(7)) * cos(q(8)) * cos(q(9)) + cos(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_KFE_CoM(3,2) = cos(q(7)) * cos(q(8)) * sin(q(9)) + cos(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_KFE_CoM(3,3) = -sin(q(7));
HT_LH_KFE_CoM(3,4) = -0.109015e0 * cos(q(7)) * cos(q(8)) * cos(q(9)) + 0.109015e0 * cos(q(7)) * sin(q(8)) * sin(q(9)) + cos(q(7)) * cos(q(8)) * sin(q(9)) * (-0.421469999999999970e-1) + cos(q(7)) * sin(q(8)) * cos(q(9)) * (-0.421469999999999970e-1) + sin(q(7)) * (-0.116781000000000010e0) - 0.360e0 * cos(q(7)) * cos(q(8));

HT_RH_KFE_CoM(1,1) = -0.1e1 * sin(q(11)) * cos(q(12)) - 0.1e1 * cos(q(11)) * sin(q(12));
HT_RH_KFE_CoM(1,2) = 0.1e1 * sin(q(11)) * sin(q(12)) - 0.1e1 * cos(q(11)) * cos(q(12));
HT_RH_KFE_CoM(1,4) = -0.443500000000000005e0 - 0.109015e0 * sin(q(11)) * cos(q(12)) - 0.109015e0 * cos(q(11)) * sin(q(12)) + sin(q(11)) * sin(q(12)) * (-0.421469999999999970e-1) + cos(q(11)) * cos(q(12)) * 0.421469999999999970e-1 - 0.360e0 * sin(q(11));
HT_RH_KFE_CoM(2,1) = 0.1e1 * sin(q(10)) * cos(q(11)) * cos(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_KFE_CoM(2,2) = -0.1e1 * sin(q(10)) * cos(q(11)) * sin(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_KFE_CoM(2,3) = 0.1e1 * cos(q(10));
HT_RH_KFE_CoM(2,4) = 0.109015e0 * sin(q(10)) * cos(q(11)) * cos(q(12)) - 0.109015e0 * sin(q(10)) * sin(q(11)) * sin(q(12)) + sin(q(10)) * cos(q(11)) * sin(q(12)) * 0.421469999999999970e-1 + sin(q(10)) * sin(q(11)) * cos(q(12)) * 0.421469999999999970e-1 + cos(q(10)) * (-0.117219000000000004e0) + 0.360e0 * sin(q(10)) * cos(q(11)) - 0.9700000000e-1;
HT_RH_KFE_CoM(3,1) = -cos(q(10)) * cos(q(11)) * cos(q(12)) + cos(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_KFE_CoM(3,2) = cos(q(10)) * cos(q(11)) * sin(q(12)) + cos(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_KFE_CoM(3,3) = sin(q(10));
HT_RH_KFE_CoM(3,4) = -0.109015e0 * cos(q(10)) * cos(q(11)) * cos(q(12)) + 0.109015e0 * cos(q(10)) * sin(q(11)) * sin(q(12)) + cos(q(10)) * cos(q(11)) * sin(q(12)) * (-0.421469999999999970e-1) + cos(q(10)) * sin(q(11)) * cos(q(12)) * (-0.421469999999999970e-1) + sin(q(10)) * (-0.117219000000000004e0) - 0.360e0 * cos(q(10)) * cos(q(11));

LF_HAA_CoM = HT_LF_HAA_CoM;
RF_HAA_CoM = HT_RF_HAA_CoM;
LH_HAA_CoM = HT_LH_HAA_CoM;
RH_HAA_CoM = HT_RH_HAA_CoM;
LF_HFE_CoM = HT_LF_HFE_CoM;
RF_HFE_CoM = HT_RF_HFE_CoM;
LH_HFE_CoM = HT_LH_HFE_CoM;
RH_HFE_CoM = HT_RH_HFE_CoM;
LF_KFE_CoM = HT_LF_KFE_CoM;
RF_KFE_CoM = HT_RF_KFE_CoM;
LH_KFE_CoM = HT_LH_KFE_CoM;
RH_KFE_CoM = HT_RH_KFE_CoM;

end

