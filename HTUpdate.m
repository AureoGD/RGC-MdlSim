function [LF_foot, RF_foot, LH_foot, RH_foot, LF_HAA, RF_HAA, LH_HAA, RH_HAA, LF_HFE, RF_HFE, LH_HFE, RH_HFE, LF_KFE, RF_KFE, LH_KFE, RH_KFE] = HTUpdate(q)

persistent HT_LF_foot HT_RF_foot HT_LH_foot HT_RH_foot HT_LF_HAA HT_RF_HAA HT_LH_HAA HT_RH_HAA HT_LF_HFE HT_RF_HFE HT_LH_HFE HT_RH_HFE HT_LF_KFE HT_RF_KFE HT_LH_KFE HT_RH_KFE
if isempty(HT_LF_foot)
    HT_LF_foot = zeros(4);
    HT_RF_foot = zeros(4);
    HT_LH_foot = zeros(4);
    HT_RH_foot = zeros(4);
    
    HT_LF_HAA = zeros(4);
    HT_RF_HAA = zeros(4);
    HT_LH_HAA = zeros(4);
    HT_RH_HAA = zeros(4);
    
    HT_LF_HFE = zeros(4);
    HT_RF_HFE = zeros(4);
    HT_LH_HFE = zeros(4);
    HT_RH_HFE = zeros(4);
    
    HT_LF_KFE = zeros(4);
    HT_RF_KFE = zeros(4);
    HT_LH_KFE = zeros(4);
    HT_RH_KFE = zeros(4);
    
    HT_LF_HAA(4,4) = 0.1e1;
    HT_RF_HAA(4,4) = 0.1e1;
    HT_LH_HAA(4,4) = 0.1e1;
    HT_RH_HAA(4,4) = 0.1e1;
    
    HT_LF_HFE(4,4) = 0.1e1;
    HT_RF_HFE(4,4) = 0.1e1;
    HT_LH_HFE(4,4) = 0.1e1;
    HT_RH_HFE(4,4) = 0.1e1;
    
    HT_LF_KFE(4,4) = 0.1e1;
    HT_RF_KFE(4,4) = 0.1e1;
    HT_LH_KFE(4,4) = 0.1e1;
    HT_RH_KFE(4,4) = 0.1e1;
    
    HT_LF_foot(4,4) = 0.1e1;
    HT_RF_foot(4,4) = 0.1e1;
    HT_LH_foot(4,4) = 0.1e1;
    HT_RH_foot(4,4) = 0.1e1;
    
    HT_LF_HAA(1,3) = -0.1e1;
    HT_LF_HAA(1,4) = 0.4435000000e0;
    HT_LF_HAA(2,4) = 0.9700000000e-1;
    HT_RF_HAA(1,3) = 0.1e1;
    HT_RF_HAA(1,4) = 0.4435000000e0;
    HT_RF_HAA(2,4) = -0.9700000000e-1;
    HT_LH_HAA(1,3) = -0.1e1;
    HT_LH_HAA(1,4) = -0.4435000000e0;
    HT_LH_HAA(2,4) = 0.9700000000e-1;
    HT_RH_HAA(1,3) = 0.1e1;
    HT_RH_HAA(1,4) = -0.4435000000e0;
    HT_RH_HAA(2,4) = -0.9700000000e-1;
    HT_LF_HFE(1,4) = 0.4435000000e0;
    HT_RF_HFE(1,4) = 0.4435000000e0;
    HT_LH_HFE(1,4) = -0.4435000000e0;
    HT_RH_HFE(1,4) = -0.4435000000e0;
    
end

% HAA

HT_LF_HAA(2,1) = -0.1e1 * sin(q(1));
HT_LF_HAA(2,2) = -0.1e1 * cos(q(1));
HT_LF_HAA(3,1) = -cos(q(1));
HT_LF_HAA(3,2) = sin(q(1));

HT_RF_HAA(2,1) = 0.1e1 * sin(q(4));
HT_RF_HAA(2,2) = 0.1e1 * cos(q(4));
HT_RF_HAA(3,1) = -cos(q(4));
HT_RF_HAA(3,2) = sin(q(4));

HT_LH_HAA(2,1) = -0.1e1 * sin(q(7));
HT_LH_HAA(2,2) = -0.1e1 * cos(q(7));
HT_LH_HAA(3,1) = -cos(q(7));
HT_LH_HAA(3,2) = sin(q(7));

HT_RH_HAA(2,1) = 0.1e1 * sin(q(10));
HT_RH_HAA(2,2) = 0.1e1 * cos(q(10));
HT_RH_HAA(3,1) = -cos(q(10));
HT_RH_HAA(3,2) = sin(q(10));

%HFE
HT_LF_HFE(1,1) = -0.1e1 * sin(q(2));
HT_LF_HFE(1,2) = -0.1e1 * cos(q(2));
HT_LF_HFE(2,1) = -0.1e1 * sin(q(1)) * cos(q(2));
HT_LF_HFE(2,2) = 0.1e1 * sin(q(1)) * sin(q(2));
HT_LF_HFE(2,3) = 0.1e1 * cos(q(1));
HT_LF_HFE(2,4) = 0.9700000000e-1 + 0.117e0 * cos(q(1));
HT_LF_HFE(3,1) = -cos(q(1)) * cos(q(2));
HT_LF_HFE(3,2) = cos(q(1)) * sin(q(2));
HT_LF_HFE(3,3) = -sin(q(1));
HT_LF_HFE(3,4) = -0.117e0 * sin(q(1));

HT_RF_HFE(1,1) = -0.1e1 * sin(q(5));
HT_RF_HFE(1,2) = -0.1e1 * cos(q(5));
HT_RF_HFE(2,1) = 0.1e1 * sin(q(4)) * cos(q(5));
HT_RF_HFE(2,2) = -0.1e1 * sin(q(4)) * sin(q(5));
HT_RF_HFE(2,3) = 0.1e1 * cos(q(4));
HT_RF_HFE(2,4) = -0.9700000000e-1 - 0.117e0 * cos(q(4));
HT_RF_HFE(3,1) = -cos(q(4)) * cos(q(5));
HT_RF_HFE(3,2) = cos(q(4)) * sin(q(5));
HT_RF_HFE(3,3) = sin(q(4));
HT_RF_HFE(3,4) = -0.117e0 * sin(q(4));

HT_LH_HFE(1,1) = -0.1e1 * sin(q(8));
HT_LH_HFE(1,2) = -0.1e1 * cos(q(8));
HT_LH_HFE(2,1) = -0.1e1 * sin(q(7)) * cos(q(8));
HT_LH_HFE(2,2) = 0.1e1 * sin(q(7)) * sin(q(8));
HT_LH_HFE(2,3) = 0.1e1 * cos(q(7));
HT_LH_HFE(2,4) = 0.9700000000e-1 + 0.117e0 * cos(q(7));
HT_LH_HFE(3,1) = -cos(q(7)) * cos(q(8));
HT_LH_HFE(3,2) = cos(q(7)) * sin(q(8));
HT_LH_HFE(3,3) = -sin(q(7));
HT_LH_HFE(3,4) = -0.117e0 * sin(q(7));

HT_RH_HFE(1,1) = -0.1e1 * sin(q(11));
HT_RH_HFE(1,2) = -0.1e1 * cos(q(11));
HT_RH_HFE(2,1) = 0.1e1 * sin(q(10)) * cos(q(11));
HT_RH_HFE(2,2) = -0.1e1 * sin(q(10)) * sin(q(11));
HT_RH_HFE(2,3) = 0.1e1 * cos(q(10));
HT_RH_HFE(2,4) = -0.9700000000e-1 - 0.117e0 * cos(q(10));
HT_RH_HFE(3,1) = -cos(q(10)) * cos(q(11));
HT_RH_HFE(3,2) = cos(q(10)) * sin(q(11));
HT_RH_HFE(3,3) = sin(q(10));
HT_RH_HFE(3,4) = -0.117e0 * sin(q(10));

%KFE

HT_LF_KFE(1,1) = -0.1e1 * sin(q(2)) * cos(q(3)) - 0.1e1 * cos(q(2)) * sin(q(3));
HT_LF_KFE(1,2) = 0.1e1 * sin(q(2)) * sin(q(3)) - 0.1e1 * cos(q(2)) * cos(q(3));
HT_LF_KFE(1,4) = 0.4435000000e0 - 0.360e0 * sin(q(2));
HT_LF_KFE(2,1) = -0.1e1 * sin(q(1)) * cos(q(2)) * cos(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_KFE(2,2) = 0.1e1 * sin(q(1)) * cos(q(2)) * sin(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_KFE(2,3) = 0.1e1 * cos(q(1));
HT_LF_KFE(2,4) = -0.360e0 * sin(q(1)) * cos(q(2)) + 0.9700000000e-1 + 0.117e0 * cos(q(1));
HT_LF_KFE(3,1) = -cos(q(1)) * cos(q(2)) * cos(q(3)) + cos(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_KFE(3,2) = cos(q(1)) * cos(q(2)) * sin(q(3)) + cos(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_KFE(3,3) = -sin(q(1));
HT_LF_KFE(3,4) = -0.360e0 * cos(q(1)) * cos(q(2)) - 0.117e0 * sin(q(1));

HT_RF_KFE(1,1) = -0.1e1 * sin(q(5)) * cos(q(6)) - 0.1e1 * cos(q(5)) * sin(q(6));
HT_RF_KFE(1,2) = 0.1e1 * sin(q(5)) * sin(q(6)) - 0.1e1 * cos(q(5)) * cos(q(6));
HT_RF_KFE(1,4) = 0.4435000000e0 - 0.360e0 * sin(q(5));
HT_RF_KFE(2,1) = 0.1e1 * sin(q(4)) * cos(q(5)) * cos(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_KFE(2,2) = -0.1e1 * sin(q(4)) * cos(q(5)) * sin(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_KFE(2,3) = 0.1e1 * cos(q(4));
HT_RF_KFE(2,4) = 0.360e0 * sin(q(4)) * cos(q(5)) - 0.9700000000e-1 - 0.117e0 * cos(q(4));
HT_RF_KFE(3,1) = -cos(q(4)) * cos(q(5)) * cos(q(6)) + cos(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_KFE(3,2) = cos(q(4)) * cos(q(5)) * sin(q(6)) + cos(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_KFE(3,3) = sin(q(4));
HT_RF_KFE(3,4) = -0.360e0 * cos(q(4)) * cos(q(5)) - 0.117e0 * sin(q(4));

HT_LH_KFE(1,1) = -0.1e1 * sin(q(8)) * cos(q(9)) - 0.1e1 * cos(q(8)) * sin(q(9));
HT_LH_KFE(1,2) = 0.1e1 * sin(q(8)) * sin(q(9)) - 0.1e1 * cos(q(8)) * cos(q(9));
HT_LH_KFE(1,4) = -0.4435000000e0 - 0.360e0 * sin(q(8));
HT_LH_KFE(2,1) = -0.1e1 * sin(q(7)) * cos(q(8)) * cos(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_KFE(2,2) = 0.1e1 * sin(q(7)) * cos(q(8)) * sin(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_KFE(2,3) = 0.1e1 * cos(q(7));
HT_LH_KFE(2,4) = -0.360e0 * sin(q(7)) * cos(q(8)) + 0.9700000000e-1 + 0.117e0 * cos(q(7));
HT_LH_KFE(3,1) = -cos(q(7)) * cos(q(8)) * cos(q(9)) + cos(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_KFE(3,2) = cos(q(7)) * cos(q(8)) * sin(q(9)) + cos(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_KFE(3,3) = -sin(q(7));
HT_LH_KFE(3,4) = -0.360e0 * cos(q(7)) * cos(q(8)) - 0.117e0 * sin(q(7));

HT_RH_KFE(1,1) = -0.1e1 * sin(q(11)) * cos(q(12)) - 0.1e1 * cos(q(11)) * sin(q(12));
HT_RH_KFE(1,2) = 0.1e1 * sin(q(11)) * sin(q(12)) - 0.1e1 * cos(q(11)) * cos(q(12));
HT_RH_KFE(1,4) = -0.4435000000e0 - 0.360e0 * sin(q(11));
HT_RH_KFE(2,1) = 0.1e1 * sin(q(10)) * cos(q(11)) * cos(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_KFE(2,2) = -0.1e1 * sin(q(10)) * cos(q(11)) * sin(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_KFE(2,3) = 0.1e1 * cos(q(10));
HT_RH_KFE(2,4) = 0.360e0 * sin(q(10)) * cos(q(11)) - 0.9700000000e-1 - 0.117e0 * cos(q(10));
HT_RH_KFE(3,1) = -cos(q(10)) * cos(q(11)) * cos(q(12)) + cos(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_KFE(3,2) = cos(q(10)) * cos(q(11)) * sin(q(12)) + cos(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_KFE(3,3) = sin(q(10));
HT_RH_KFE(3,4) = -0.360e0 * cos(q(10)) * cos(q(11)) - 0.117e0 * sin(q(10));


%Foot
HT_LF_foot(1,1) = -0.1e1 * sin(q(2)) * cos(q(3)) - 0.1e1 * cos(q(2)) * sin(q(3));
HT_LF_foot(1,2) = 0.1e1 * sin(q(2)) * sin(q(3)) - 0.1e1 * cos(q(2)) * cos(q(3));
HT_LF_foot(1,4) = -0.380e0 * sin(q(2)) * cos(q(3)) - 0.380e0 * cos(q(2)) * sin(q(3)) + 0.4435000000e0 - 0.360e0 * sin(q(2));
HT_LF_foot(2,1) = -0.1e1 * sin(q(1)) * cos(q(2)) * cos(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_foot(2,2) = 0.1e1 * sin(q(1)) * cos(q(2)) * sin(q(3)) + 0.1e1 * sin(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_foot(2,3) = 0.1e1 * cos(q(1));
HT_LF_foot(2,4) = -0.380e0 * sin(q(1)) * cos(q(2)) * cos(q(3)) + 0.380e0 * sin(q(1)) * sin(q(2)) * sin(q(3)) - 0.360e0 * sin(q(1)) * cos(q(2)) + 0.9700000000e-1 + 0.117e0 * cos(q(1));
HT_LF_foot(3,1) = -cos(q(1)) * cos(q(2)) * cos(q(3)) + cos(q(1)) * sin(q(2)) * sin(q(3));
HT_LF_foot(3,2) = cos(q(1)) * cos(q(2)) * sin(q(3)) + cos(q(1)) * sin(q(2)) * cos(q(3));
HT_LF_foot(3,3) = -sin(q(1));
HT_LF_foot(3,4) = -0.380e0 * cos(q(1)) * cos(q(2)) * cos(q(3)) + 0.380e0 * cos(q(1)) * sin(q(2)) * sin(q(3)) - 0.360e0 * cos(q(1)) * cos(q(2)) - 0.117e0 * sin(q(1));

HT_RF_foot(1,1) = -0.1e1 * sin(q(5)) * cos(q(6)) - 0.1e1 * cos(q(5)) * sin(q(6));
HT_RF_foot(1,2) = 0.1e1 * sin(q(5)) * sin(q(6)) - 0.1e1 * cos(q(5)) * cos(q(6));
HT_RF_foot(1,3) = 0.0e0;
HT_RF_foot(1,4) = -0.40175e0 * sin(q(5)) * cos(q(6)) - 0.40175e0 * cos(q(5)) * sin(q(6)) + 0.4435000000e0 - 0.360e0 * sin(q(5));
HT_RF_foot(2,1) = 0.1e1 * sin(q(4)) * cos(q(5)) * cos(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_foot(2,2) = -0.1e1 * sin(q(4)) * cos(q(5)) * sin(q(6)) - 0.1e1 * sin(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_foot(2,3) = 0.1e1 * cos(q(4));
HT_RF_foot(2,4) = 0.40175e0 * sin(q(4)) * cos(q(5)) * cos(q(6)) - 0.40175e0 * sin(q(4)) * sin(q(5)) * sin(q(6)) + 0.360e0 * sin(q(4)) * cos(q(5)) - 0.9700000000e-1 - 0.117e0 * cos(q(4));
HT_RF_foot(3,1) = -cos(q(4)) * cos(q(5)) * cos(q(6)) + cos(q(4)) * sin(q(5)) * sin(q(6));
HT_RF_foot(3,2) = cos(q(4)) * cos(q(5)) * sin(q(6)) + cos(q(4)) * sin(q(5)) * cos(q(6));
HT_RF_foot(3,3) = sin(q(4));
HT_RF_foot(3,4) = -0.40175e0 * cos(q(4)) * cos(q(5)) * cos(q(6)) + 0.40175e0 * cos(q(4)) * sin(q(5)) * sin(q(6)) - 0.360e0 * cos(q(4)) * cos(q(5)) - 0.117e0 * sin(q(4));

HT_LH_foot(1,1) = -0.1e1 * sin(q(8)) * cos(q(9)) - 0.1e1 * cos(q(8)) * sin(q(9));
HT_LH_foot(1,2) = 0.1e1 * sin(q(8)) * sin(q(9)) - 0.1e1 * cos(q(8)) * cos(q(9));
HT_LH_foot(1,3) = 0.0e0;
HT_LH_foot(1,4) = -0.40175e0 * sin(q(8)) * cos(q(9)) - 0.40175e0 * cos(q(8)) * sin(q(9)) - 0.4435000000e0 - 0.360e0 * sin(q(8));
HT_LH_foot(2,1) = -0.1e1 * sin(q(7)) * cos(q(8)) * cos(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_foot(2,2) = 0.1e1 * sin(q(7)) * cos(q(8)) * sin(q(9)) + 0.1e1 * sin(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_foot(2,3) = 0.1e1 * cos(q(7));
HT_LH_foot(2,4) = -0.40175e0 * sin(q(7)) * cos(q(8)) * cos(q(9)) + 0.40175e0 * sin(q(7)) * sin(q(8)) * sin(q(9)) - 0.360e0 * sin(q(7)) * cos(q(8)) + 0.9700000000e-1 + 0.117e0 * cos(q(7));
HT_LH_foot(3,1) = -cos(q(7)) * cos(q(8)) * cos(q(9)) + cos(q(7)) * sin(q(8)) * sin(q(9));
HT_LH_foot(3,2) = cos(q(7)) * cos(q(8)) * sin(q(9)) + cos(q(7)) * sin(q(8)) * cos(q(9));
HT_LH_foot(3,3) = -sin(q(7));
HT_LH_foot(3,4) = -0.40175e0 * cos(q(7)) * cos(q(8)) * cos(q(9)) + 0.40175e0 * cos(q(7)) * sin(q(8)) * sin(q(9)) - 0.360e0 * cos(q(7)) * cos(q(8)) - 0.117e0 * sin(q(7));

HT_RH_foot(1,1) = -0.1e1 * sin(q(11)) * cos(q(12)) - 0.1e1 * cos(q(11)) * sin(q(12));
HT_RH_foot(1,2) = 0.1e1 * sin(q(11)) * sin(q(12)) - 0.1e1 * cos(q(11)) * cos(q(12));
HT_RH_foot(1,3) = 0.0e0;
HT_RH_foot(1,4) = -0.40175e0 * sin(q(11)) * cos(q(12)) - 0.40175e0 * cos(q(11)) * sin(q(12)) - 0.4435000000e0 - 0.360e0 * sin(q(11));
HT_RH_foot(2,1) = 0.1e1 * sin(q(10)) * cos(q(11)) * cos(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_foot(2,2) = -0.1e1 * sin(q(10)) * cos(q(11)) * sin(q(12)) - 0.1e1 * sin(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_foot(2,3) = 0.1e1 * cos(q(10));
HT_RH_foot(2,4) = 0.40175e0 * sin(q(10)) * cos(q(11)) * cos(q(12)) - 0.40175e0 * sin(q(10)) * sin(q(11)) * sin(q(12)) + 0.360e0 * sin(q(10)) * cos(q(11)) - 0.9700000000e-1 - 0.117e0 * cos(q(10));
HT_RH_foot(3,1) = -cos(q(10)) * cos(q(11)) * cos(q(12)) + cos(q(10)) * sin(q(11)) * sin(q(12));
HT_RH_foot(3,2) = cos(q(10)) * cos(q(11)) * sin(q(12)) + cos(q(10)) * sin(q(11)) * cos(q(12));
HT_RH_foot(3,3) = sin(q(10));
HT_RH_foot(3,4) = -0.40175e0 * cos(q(10)) * cos(q(11)) * cos(q(12)) + 0.40175e0 * cos(q(10)) * sin(q(11)) * sin(q(12)) - 0.360e0 * cos(q(10)) * cos(q(11)) - 0.117e0 * sin(q(10));


LF_foot = HT_LF_foot;
RF_foot = HT_RF_foot;
LH_foot = HT_LH_foot;
RH_foot = HT_RH_foot;
LF_HAA = HT_LF_HAA;
RF_HAA = HT_RF_HAA;
LH_HAA =  HT_LH_HAA;
RH_HAA = HT_RH_HAA;
LF_HFE = HT_LF_HFE;
RF_HFE = HT_RF_HFE;
LH_HFE = HT_LH_HFE;
RH_HFE = HT_RH_HFE;
LF_KFE = HT_LF_KFE;
RF_KFE = HT_RF_KFE;
LH_KFE = HT_LH_KFE;
RH_KFE = HT_RH_KFE;

end

