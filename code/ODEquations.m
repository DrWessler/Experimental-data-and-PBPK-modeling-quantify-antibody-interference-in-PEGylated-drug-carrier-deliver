%{
name:
ODEquations

version:
wessler
2021 May 10
1st version

description:
File that includes all ODEs for the PBPK model by Talkington et al 2021.
The equations here are in the same form as equations (1)-(8).

used by:
RunSingleSimulation.m

uses:
NOTHING--this is a file used by MATLAB ODE solver


NOTES:

from text:

*C_comp=concentration of compartment "comp"
*V_comp=volume of compartment "comp"
*Q_comp=flow rate into compartment "comp"
*fr_comp=permeability fraction, extravasation rate into compartment "comp"
*Kp_comp=partitioning coefficient in compartment "comp"
*CL_comp=clearance rate in compartment "comp"

p=venous plasma, li=liver, k=kidney, s=spleen, m=muscle, a=arterial plasma,
lu=lung, r=remainder compartment

%}





function XDot = ODEquations(~,ODEVec,ODEParams)
global V_li V_k V_s V_m V_a V_p V_lu V_r
global Q_li Q_k Q_s Q_m Q_lu Q_r
global fr_li fr_k fr_s fr_m fr_lu fr_r
global Kp_li Kp_k Kp_s Kp_m Kp_lu Kp_r
global CL_p



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%unpack terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
%params
%==========================================================================

CompartmentIDs=ODEParams.CompartmentIDs;



%==========================================================================
%ODE variables
%==========================================================================

C_li=ODEVec(CompartmentIDs.Liver);
C_k=ODEVec(CompartmentIDs.Kidneys);
C_s=ODEVec(CompartmentIDs.Spleen);
C_m=ODEVec(CompartmentIDs.Muscles);
C_a=ODEVec(CompartmentIDs.Arteries);
C_p=ODEVec(CompartmentIDs.Plasma);
C_lu=ODEVec(CompartmentIDs.Lungs);
C_r=ODEVec(CompartmentIDs.Remainder);

XDot=zeros(CompartmentIDs.NumberOfIDs,1);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%update equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%==========================================================================
%liver
%==========================================================================
CompartmentID=CompartmentIDs.Liver;

XDot(CompartmentID) = 0 ...
    + 1/V_li*(Q_li*fr_li*C_a - (Q_li*fr_li+Q_s*fr_s)*C_li/Kp_li) ...
    + Q_s*fr_s/V_li*(C_s/Kp_s) ...
    ;


%==========================================================================
%kidneys
%==========================================================================
CompartmentID=CompartmentIDs.Kidneys;

XDot(CompartmentID) = 0 ...
    + Q_k*fr_k/V_k*(C_a-C_k/Kp_k) ...
    ;

%==========================================================================
%spleen
%==========================================================================
CompartmentID=CompartmentIDs.Spleen;

XDot(CompartmentID) = 0 ...
    + Q_s*fr_s/V_s*(C_a-C_s/Kp_s) ...
    ;


%==========================================================================
%muscles
%==========================================================================
CompartmentID=CompartmentIDs.Muscles;

XDot(CompartmentID) = 0 ...
    + Q_m*fr_m/V_m*(C_a-C_m/Kp_m) ...
    ;


%==========================================================================
%arteries
%==========================================================================
CompartmentID=CompartmentIDs.Arteries;

XDot(CompartmentID) = 0 ...
    + Q_lu*fr_lu/V_a*(C_lu/Kp_lu) ...
    - C_a*(Q_li*fr_li/V_a + Q_m*fr_m/V_a + Q_s*fr_s/V_a + Q_k*fr_k/V_a + Q_r*fr_r/V_a) ...
    ;


%==========================================================================
%plasma
%==========================================================================
CompartmentID=CompartmentIDs.Plasma;

XDot(CompartmentID) = 0 ...
    + 1/V_p*(-C_p*CL_p) ...
    - Q_lu*fr_lu*C_p/V_p ...
    + (Q_li*fr_li+Q_s*fr_s)/V_p*(C_li/Kp_li) ...
    + Q_m*fr_m/V_p*(C_m/Kp_m) ...
    + Q_k*fr_k/V_p*(C_k/Kp_k) ...
    + Q_r*fr_r/V_p*(C_r/Kp_r) ...
    ;


%==========================================================================
%lungs
%==========================================================================
CompartmentID=CompartmentIDs.Lungs;

XDot(CompartmentID) = 0 ...
    + Q_lu*fr_lu*C_p/V_lu ...
    - Q_lu*fr_lu*C_lu/(V_lu*Kp_lu) ...
    ;


%==========================================================================
%remainder
%==========================================================================
CompartmentID=CompartmentIDs.Remainder;

XDot(CompartmentID) = 0 ...
    + Q_r*fr_r/V_r*(C_a-C_r/Kp_r) ...
    ;





end










