wessler
2021 June 29





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Summary of files included
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RunSingleSimulation.m
This is the code to run. It performs 1 simulation of 1 in silico mouse.

ODEquations.m
This includes the ODEs for the PBPK model. It is used by RunSingleSimulation.m.

Inputs_InitialConditions.m
This includes the initial state of the system (initial concentration of Drug in each compartment). The values used in Talkington et al. are given in paper. It is run (read) by RunSingleSimulation.m.

Inputs_ODEParamVals.m
This includes the values of all parameters that appear in the ODEs that appear in Talkington et al.

It should be noted that values listed in Talkington et al. may need to undergo unit conversions in order to compare to PET/CT data. This includes scaling the organ volumes from those listed for a typical 20g mouse to the weight of an experimental mouse. Further, the ODEs in Talkington et al. were designed to solve for changes in concentration of drug in the tissue, and PET/CT data corresponds to total concentration (both in the tissue and surrounding fluid), so blood distribution data from Brown et al. 1997 and Kaliss 1950 must be used along with the outputs from the ODE solver to compare to PET/CT data.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Run instructions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) Edit Inputs_InitialConditions.m to define the initial concentrations in each compartment.

(2) Edit Inputs_ODEParamVals.m to define the parameter values for each parameter that appears in the ODEs for Talkington et al.

(3) Edit RunSingleSimulation.m to include the desired end time (TimeEnd) and perhaps the desired ODE solver tolerance terms (RelTol and AbsTol).

(4) Run RunSingleSimulation.m




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Using outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

After running RunSingleSimulation.m, there will be the following terms in the MATLAB workspace:
*ODETimeVals
*ODEVarVals


ODETimeVals is a (k-by-1) vector that represent the time stamps (in minutes, unless the terms in Inputs_ODEParamVals.m are different) for the terms in ODEVarVals.

ODEVarVals is a (k-by-CompartmentIDs.NumberOfIDs) array, where each (k-by-1) column represents the concentration of drug in the tissue of the compartment at each time stamp.

Ex. ODEVarVals("a","b") is the concentration of the compartment whose CompartmentIDs value is "b" at time ODETimeVals("a").

Ex. A time-series plot of the concentration of drug in liver tissue can be done by the following:
plot(ODETimeVals, ODEVarVals(:,CompartmentIDs.Liver))




