clc
clear all
close all

%% ******************************** Inputs *********************************

rho = 1.225;                        %% Denisty
meu = 1.5e-5;                       %% Kinematic Viscosity

MTOW = 2.5 * 9.8;                     %% Max Takeoff weight
V_stall = 8;                        %% Stall velocity
CL_max = 1.3;                   %% Max lift coeff
CL_cruise = 0.2:0.01:0.5;           %% Cruise lift coeff
AR = 7;                             %% wing aspect ratio

SH_to_Sw =0.25;      %% Horizontal tail area to wing area ratio
V_HT = 0.4;             %% Horizontal tail volumetric ratio
AR_H = 3;                           %% Horizontal tail aspect ratio


V_VT = 0.02 : 0.005 : 0.05;         %% Horizontal tail volumetric ratio
AR_V = 3;                           %% Vertical tail aspect ratio

TR = 1;                             %% Taper ratio
Sweep = 0;                          %% Sweep
Root_Twist = 3;                     %% Twist

%% ****************************** Desingn Parameters ***********************
DP_1(1,:)={"WingArea","Cruise Speed","Stall Speed","Max Lift Coeff","Cruise Lift Coeff"};

Sw = MTOW/(0.5*rho*(V_stall^2)*CL_max);
b = sqrt(Sw * AR);
Cw = b / AR;

count = 1;
    for j = 1:length(V_stall)
        for k = 1:length(CL_max)
            for l = 1:length(CL_cruise)
                
                V_cruise = sqrt(MTOW/(0.5*rho*Sw*CL_cruise(l)));
                
                if V_cruise >= 13 && V_cruise <= 18
                    
                    Para(count,1) = double(Sw);
                    DP_1(count+1,1) = {Sw};
                    
                    Para(count,2) = double(V_cruise);
                    DP_1(count+1,2) = {V_cruise};
                    
                    Para(count,3) = double(V_stall(j));
                    DP_1(count+1,3) = {V_stall(j)};
                    
                    Para(count,4) = double(CL_max(k));
                    DP_1(count+1,4) = {CL_max(k)};
                    
                    Para(count,5) = double(CL_cruise(l));
                    DP_1(count+1,5) = {CL_cruise(l)};
                    
                    count = count + 1 ;
                end
            end
        end
    end
        
%% ************************************** Wing Size ***********************
DP_2(1,:)={"Aspect Ratio","Taper Ratio","WIng Area","Span","Root Chord","Tip Chord","Mean Aerodynamic center"};

count = 1;
for i = 1 : length(AR)
    for j = 1 : length(TR)
        
        DP_2(count+1,1) = {AR(i)};
        DP_2(count+1,2) = {TR(j)};
        DP_2(count+1,3) = {Sw};
        
        b(count) = sqrt(AR(i)*Sw);
        DP_2(count+1,4) = {b(count)};
        
        Cr(count) = (2 * Sw)/(b(count)*(1 + TR(j)));
        DP_2(count+1,5) = {Cr(count)};
        
        Ct(count) = TR(j) * Cr(count);
        DP_2(count+1,6) = {Ct(count)};
        
        MAC(count) = (2/3) * Cr(count) * ((1 + TR(j) + TR(j)^2)/(1 + TR(j)));
        DP_2(count+1,7) = {MAC(count)};
        
        count = count + 1;
    end
end


%% ************************************** Tail Size ***********************
DP_3(1,:)={"Wing Area","MAC","Wing Span","HT Vol. Ratio","HT AR","HT Area / Wing Area","HT Area","HT Arm","HT Span","HT Chord","VT Vol. Ratio","VT AR","VT Arm","VT Area","VT Span","VT Chord"};

count = 1;
for i = 1 : length(SH_to_Sw)
    for j = 1 : length(V_HT)
        for k = 1 : length(MAC)
            for l = 1 : length(V_VT)
                
                DP_3(count+1,1) = {Sw};
                DP_3(count+1,2) = {MAC(k)};
                DP_3(count+1,3) = {b(k)};
                
                DP_3(count+1,4) = {V_HT(j)};
                DP_3(count+1,5) = {AR_H};
                DP_3(count+1,6) = {SH_to_Sw(i)};
                
                
                SH(count) = Sw * SH_to_Sw(i);
                DP_3(count+1,7) = {SH(count)};
                
                LH(count) = V_HT(j) * Sw * MAC(k) / SH(count);
                DP_3(count+1,8) = {LH(count)};
                
                bH(count) = sqrt(AR_H * SH(count));
                DP_3(count+1,9) = {bH(count)};
                
                CH(count) = bH(count) / AR_H;
                DP_3(count+1,10) = {CH(count)};
                
                DP_3(count+1,11) = {V_VT(l)};
                DP_3(count+1,12) = {AR_V};
                
                LV(count) = LH(count);
                DP_3(count+1,13) = {LV(count)};
                
                SV(count) = (V_VT(l) * Sw * b(k)) / LV(count);
                DP_3(count+1,14) = {SV(count)};
                
                bV(count) = sqrt(AR_V * SV(count));
                DP_3(count+1,15) = {bV(count)};
                
                CV(count) = bV(count) / AR_V;
                DP_3(count+1,16) = {CV(count)};
                
                count = count + 1;
            end
        end
    end
end

% writecell(DP_1,'Task 3.xlsx','Sheet',1,'Range','A1')
% writecell(DP_2,'Task 3.xlsx','Sheet',2,'Range','A1')
% writecell(DP_3,'Task 3.xlsx','Sheet',3,'Range','A1')

%% ************************************** From XFLR ***********************

%static margin = (Xnp - Xcg) / MAC
static_margin = 0.2;
Xnp = 0.115;                                   %% Neutral Point
Xcg = Xnp - (static_margin * MAC);             %% Center of gravity
trim_angle = 1.98;

V_TO = 1.3 * V_stall ;                         %% Take-off velocity


V_cruise = 13.72;                     % From V vs Cm graph at Cm = 0 (Trim)
Re_cruise = V_cruise * MAC / meu;              %% Reynolds number at cruise


V_max = 1.3 * V_cruise;                        %% Max velocity
Re_max = V_max * MAC / meu;                    %% Max Reynolds number


%% *************************** Moment of inertia estimation ****************

r_Ixx = 0.11 * b;
Ixx = (MTOW/9.8) * r_Ixx^2;

AC_length = 0.540374078 + 0.212939843 + 0.297205743; %tail chord + tail arm + wing chord
r_Iyy = 0.175 * AC_length;
Iyy = (MTOW/9.8) * r_Iyy ^ 2;

r_Izz = 0.19 * (b + AC_length);
Izz = (MTOW/9.8) * r_Izz ^ 2 ;

%% *************************** Drag estimation ***************************
Cf = 1.328 / sqrt(Re_cruise);

tc_W = 12/100;
XCm_W = 29.03/100;

tc_t = 7/100;
XCm_t = 29.03/100;

FF_W = 1 + (0.6 / XCm_W) * tc_W + 100 * tc_W^4;
FF_t = 2 * (1 + (0.6 / XCm_t) * tc_t + 100 * tc_t^4);

FF = FF_W + FF_t;

Swet_W = 2 * (1 + 0.2 * tc_W) * Sw;
Swet_t = 2 * (1 + 0.2 * tc_t) * (0.136030131 + 0.095221091);

Swet = Swet_W + Swet_t;

Cdo = Cf * FF * Swet / Sw;