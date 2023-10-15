%% Constraints
%Max MTOW = 2.5 Kg
%Max span (b) = 1.6 m
%Max airfoil thickness = 0.0045 m

%% Don't Go Far From the Following Ranges
%Cruise speed ranges from 13 to 18 m/s
%Stall speed ranges from 5 to 8 m/s (the lower the better)
%V_HT ranges from 0.3 to 0.6
%V_VT ranges from 0.02 to 0.05
%SH/Sw ranges from 0.2 to 0.25
%AR_VT is 3
%AR_HT is 3

%%  Design mission
%Light weight as much as possible (small areas)
%High range and endurance to achieve the 3 laps goals
%High V_cruise

%Remember that for electricall powered UAVs (like ours), Because their
%weight remains the same, In this case the goal is to minimize the total
%power required from the battery
%The endurance then = battery output power (watt) / tot. power req. (watt)
%The range then = endurance * V_cruise

%% ******************************** Inputs *********************************
clc
clear all
close all

rho = 1.225;                                       %% Denisty
meu = 1.5e-5;                                      %% Kinematic Viscosity

MTOW = 2.3 * 9.8;                                    %% Max Takeoff weight
V_stall = 7.75;                                         %% Stall velocity

%Airfoil 
CL_max = 1.52;                                     %% Max lift coeff
CL_cruise = 0.4;                                   %% Cruise lift coeff
AR = 6.25;                                            %% wing aspect ratio

SH_to_Sw = 0.205;                                    %% Horizontal tail area to wing area ratio
V_HT = 0.6;                                        %% Horizontal tail volumetric ratio
AR_H = 3;                                          %% Horizontal tail aspect ratio


V_VT = 0.045;                        %% Vertical tail volumetric ratio
AR_V = 3;                            %% Vertical tail aspect ratio

TR = 1;                             %% Taper ratio
Sweep = 0;                          %% Sweep
Root_Twist = 0;                     %% Twist

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
                
%                 if V_cruise >= 13 && V_cruise <= 18
                    
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
%                 end
            end
        end
    end

fprintf("The Design data depending on your chosen design parameters are shown in an excel sheet \nCalled 'Iteration 1' for better visualization \nIf you're going to change your design parameters \nSave the important results somewhere else\n\n")
writecell(DP_1,'Iteration 1.xlsx','Sheet',1,'Range','A1')

%% ************************************** Wing Size ***********************
DP_2(1,:)={"Aspect Ratio","Taper Ratio","WIng Area","Span","Root Chord","Tip Chord","MAC"};

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

writecell(DP_2,'Iteration 1.xlsx','Sheet',1,'Range','A4')

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

writecell(DP_3,'Iteration 1.xlsx','Sheet',1,'Range','A7')

%% ************************************** From XFLR 

%static margin = (Xnp - Xcg) / MAC
static_margin = input("Enter Static Margin Percentage: ");
Xnp = input("Enter Neutral Point Coordinate From XFLR: "); %% Neutral Point
Xcg = Xnp - (static_margin/100 * MAC);                         %% Center of gravity

fprintf("Put The Xcg in the XFLR analysis at %0.5f \n\n",Xcg)

%% From V vs Cm graph at Cm = 0 (Trim)
DP_4(1,:) ={"Trim angle", "Take-Off Velocity", "Cruise Velocity", "Max Velocity", "Cruise Reynolds", "Max Reynolds", "Static Margin", "Xnp", "Xcg"};

trim_angle = input("Enter trim angle from XFLR: ");
DP_4(2,1) = {trim_angle};

V_TO = 1.3 * V_stall ;                         % Take-off velocity
DP_4(2,2) = {V_TO};

V_cruise = input("Enter V_cruise from XFLR: ");
DP_4(2,3) = {V_cruise};

V_max = 1.3 * V_cruise;                        % Max velocity
DP_4(2,4) = {V_max};

Re_cruise = V_cruise * MAC / meu;              % Reynolds number at cruise
DP_4(2,5) = {Re_cruise};

Re_max = V_max * MAC / meu;                    % Max Reynolds number
DP_4(2,6) = {Re_max};

DP_4(2,7) = {static_margin};
DP_4(2,8) = {Xnp};
DP_4(2,9) = {Xcg};
writecell(DP_4,'Iteration 1.xlsx','Sheet',1,'Range','A10')

%% *************************** Moment of inertia estimation 
% To be revised

DP_5(1,:) = {"Aircraft Length", "Ixx", "Iyy", "Izz", "Ixz"};

AC_length = CH + LH + Cw;               %tail chord + tail arm + wing chord
DP_5(2,1) = {AC_length};

r_Ixx = 0.11 * b;
Ixx = (MTOW/9.8) * r_Ixx^2;
DP_5(2,2) = {Ixx};

r_Iyy = 0.175 * AC_length;
Iyy = (MTOW/9.8) * r_Iyy ^ 2;
DP_5(2,3) = {Iyy};

r_Izz = 0.19 * (b + AC_length);
Izz = (MTOW/9.8) * r_Izz ^ 2 ;
DP_5(2,4) = {Izz};

Ixz = 0;
DP_5(2,5) = {Ixz};

writecell(DP_5,'Iteration 1.xlsx','Sheet',1,'Range','A13')

%% *************************** Drag estimation ***************************
% To be revised
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


%% *************************** Required Thrust ***************************
%CDTO: Drag coeffecient during T-O run --> T-O == Takeoff
%V_LOF: Liftoff speed == 1.1 V_stall to 1.3 V_stall
%Vo is equal to hand speed at launching
W_per_S = MTOW / Sw;
e = 0.8;
K = 1 / (pi * e * AR);
V_LOF = 1.2 * V_stall;
Vo = 5;                             
v_q = (V_LOF - Vo)/sqrt(2);
q = 0.5*rho*v_q^2;
Sg = 5;
CDTo = Cdo + K * CL_max^2;
g=9.8;
sigma = 1;
T_static = MTOW * (((((V_LOF)^2)-Vo^2)/(2 * g * Sg)) + (q*CDTo)/(W_per_S));
T_dynamic_max = MTOW * ( (rho * V_max ^ 2 * Cdo * (0.5 / W_per_S)) + ((2 * K * W_per_S) / (rho * sigma * V_max ^ 2)) );
T_dynamic_cruise = MTOW * ( (rho * V_cruise ^ 2 * Cdo * (0.5 / W_per_S)) + ((2 * K * W_per_S) / (rho * sigma * V_cruise ^ 2)) );



