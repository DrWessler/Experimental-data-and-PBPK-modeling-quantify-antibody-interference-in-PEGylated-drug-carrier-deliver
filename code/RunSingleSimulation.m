%{
name:
RunSingleSimulation

version:
wessler
2021 May 10
1st version

description:
This is the public version that runs a single simulation of the PBPK model
by Talkington et al 2021.
This is the script to run.

used by:
NOTHING--this is the script to run.

uses:
ODEquations.m
Inputs_InitialConditions.m
Inputs_ODEParamVals.m

%}







%==========================================================================
%simulation parameters
%==========================================================================
TimeStart=0; %[min]
TimeEnd=60; %[min]

CompartmentIDs.Liver=1;
CompartmentIDs.Kidneys=2;
CompartmentIDs.Spleen=3;
CompartmentIDs.Muscles=4;
CompartmentIDs.Arteries=5;
CompartmentIDs.Plasma=6;
CompartmentIDs.Lungs=7;
CompartmentIDs.Remainder=8;
CompartmentIDs.NumberOfIDs=8;

ODESolverOptions = odeset('NonNegative',1:CompartmentIDs.NumberOfIDs,'RelTol',1e-12,'AbsTol',1e-14);


%==========================================================================
%read parameter values and initial conditions
%==========================================================================

Inputs_ODEParamVals

Inputs_InitialConditions


%==========================================================================
%run simulation
%==========================================================================

%--------------------------------------------------------------------------
%prepare terms to send to ODE solver
%--------------------------------------------------------------------------
ODEParams.CompartmentIDs=CompartmentIDs;

ODEVec=zeros(CompartmentIDs.NumberOfIDs,1);
ODEVec(CompartmentIDs.Liver)=Conc_Liver_init;
ODEVec(CompartmentIDs.Kidneys)=Conc_Kidneys_init;
ODEVec(CompartmentIDs.Spleen)=Conc_Spleen_init;
ODEVec(CompartmentIDs.Muscles)=Conc_Muscles_init;
ODEVec(CompartmentIDs.Arteries)=Conc_Arteries_init;
ODEVec(CompartmentIDs.Plasma)=Conc_Plasma_init;
ODEVec(CompartmentIDs.Lungs)=Conc_Lungs_init;
ODEVec(CompartmentIDs.Remainder)=Conc_Remainder_init;

%--------------------------------------------------------------------------
%run ODE solver
%--------------------------------------------------------------------------

[ODETimeVals,ODEVarVals] = ode15s(@(t,ODEVec) ODEquations(t,ODEVec,ODEParams),[TimeStart TimeEnd],ODEVec,ODESolverOptions);









