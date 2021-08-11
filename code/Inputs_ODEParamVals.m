%{
name:
Inputs_ODEParamVals

version:
wessler
2021 May 10
1st version

description:
Input file.
This includes all parameters used in the ODEs for the PBPK model by
Talkington et al 2021.

used by:
RunSingleSimulation.m

uses:
NOTHING--this is an input file.


NOTES:

from text:

*V_comp=volume of compartment "comp"
*Q_comp=flow rate into compartment "comp"
*fr_comp=permeability fraction, extravasation rate into compartment "comp"
*Kp_comp=partitioning coefficient in compartment "comp"
*CL_comp=clearance rate in compartment "comp"

p=venous plasma, li=liver, k=kidney, s=spleen, m=muscle, a=arterial plasma,
lu=lung, r=remainder compartment

%}


global V_li V_k V_s V_m V_a V_p V_lu V_r
global Q_li Q_k Q_s Q_m Q_lu Q_r
global fr_li fr_k fr_s fr_m fr_lu fr_r
global Kp_li Kp_k Kp_s Kp_m Kp_lu Kp_r
global CL_p



%==========================================================================
%volumes [mL]
%==========================================================================
V_li = 
V_k = 
V_s = 
V_m = 
V_a = 
V_p = 
V_lu = 
V_r = 

%==========================================================================
%flow rates [mL/min]
%==========================================================================
Q_li = 
Q_k = 
Q_s = 
Q_m = 
Q_lu = 
Q_r = 

%==========================================================================
%permeability fractions [dimensionless]
%==========================================================================
fr_li = 
fr_k = 
fr_s = 
fr_m = 
fr_lu = 
fr_r = 

%==========================================================================
%partitioning coefficients [dimensionless]
%==========================================================================
Kp_li = 
Kp_k = 
Kp_s = 
Kp_m = 
Kp_lu = 
Kp_r = 

%==========================================================================
%clearance rates [mL/min]
%==========================================================================
CL_p = 







