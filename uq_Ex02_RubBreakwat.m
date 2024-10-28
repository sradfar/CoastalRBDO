%% RBDO: Rubble-mound Breakwater

%% 1 - INITIALIZE UQLAB
%
clearvars
rng(1,'twister')
uqlab

%% 2 - COMPUTATIONAL MODEL

%% 2.2 Limit state function
%
ModelOpts.mFile = 'uq_Ex02_RubBreakwat_constraint';
myModel = uq_createModel(ModelOpts);
RBDOOpts.LimitState.Model = myModel;

%%
% Soft constraints
RBDOOpts.SoftConstraints.mFile = 'uq_Ex02_RubBreakwat_SoftCon';

%% 3 - PROBABILISTIC INPUT MODEL
%
%% 3.1 Design variables
%
RBDOOpts.Input.DesVar(1).Name = 'a';  % Armor-layer height - X1
RBDOOpts.Input.DesVar(1).Type = 'Gaussian';
RBDOOpts.Input.DesVar(1).CoV = 0.043;

RBDOOpts.Input.DesVar(2).Name = 'b';  % Underlayer height - X2
RBDOOpts.Input.DesVar(2).Type = 'Gaussian';
RBDOOpts.Input.DesVar(2).CoV = 0.081;

RBDOOpts.Input.DesVar(3).Name = 'c';  % Core height - X3
RBDOOpts.Input.DesVar(3).Type = 'Gaussian';
RBDOOpts.Input.DesVar(3).CoV = 0.045;

RBDOOpts.Input.DesVar(4).Name = 'Cw';  % Crest width -X4
RBDOOpts.Input.DesVar(4).Type = 'Gaussian';
RBDOOpts.Input.DesVar(4).CoV = 0.098;

RBDOOpts.Input.DesVar(5).Name = 't'; % Toe thickness - X5
RBDOOpts.Input.DesVar(5).Type = 'constant';

RBDOOpts.Input.DesVar(6).Name = 'r'; % Toe berm width -X6
RBDOOpts.Input.DesVar(6).Type = 'constant';

RBDOOpts.Input.DesVar(7).Name = 'Bc'; % Core width - X7
RBDOOpts.Input.DesVar(7).Type = 'constant';

RBDOOpts.Input.DesVar(8).Name = 'al';  % Leeward slope - X8
RBDOOpts.Input.DesVar(8).Type = 'Gaussian';
RBDOOpts.Input.DesVar(8).CoV = 0.064;

RBDOOpts.Input.DesVar(9).Name = 'as';  % Seaward slope - X9
RBDOOpts.Input.DesVar(9).Type = 'Gaussian';
RBDOOpts.Input.DesVar(9).CoV = 0.092;

%% 3.2 Environmental variables

InputOpts.Marginals(1).Name = 'Delta' ;  % Relative density -X10
InputOpts.Marginals(1).Type = 'Gaussian';
InputOpts.Marginals(1).Parameters = [1.439 0.055];

InputOpts.Marginals(2).Name = 'Dn' ;  % Nominal diameter - X11
InputOpts.Marginals(2).Type = 'Gaussian';
InputOpts.Marginals(2).Parameters = [1.675 0.084];

InputOpts.Marginals(3).Name = 'KD' ;  % Stability parameter - X12
InputOpts.Marginals(3).Type = 'Gaussian';
InputOpts.Marginals(3).Parameters = [3.5 0.476];

InputOpts.Marginals(4).Name = 'Hs' ;  % Significant wave height - X13
InputOpts.Marginals(4).Type = 'Lognormal';
InputOpts.Marginals(4).Parameters = [-0.0932 0.4552];

InputOpts.Marginals(5).Name = 'Tp';  % Wave period - X14
InputOpts.Marginals(5).Type = 'Lognormal';
InputOpts.Marginals(5).Parameters = [2.2923 0.0856];

InputOpts.Marginals(6).Name = 'Nod' ;  % Failure rate - X15
InputOpts.Marginals(6).Type = 'Gaussian';
InputOpts.Marginals(6).Parameters = [4 1.2];

InputOpts.Marginals(7).Name = 'WL' ;  % Water level - X16
InputOpts.Marginals(7).Type = 'Gaussian';
InputOpts.Marginals(7).Parameters = [1.6127 0.6474];

% I commented this out because I don't have the file...
corrmat = csvread('AllCorrr.csv');
InputOpts.Copula.Type = 'Gaussian';
InputOpts.Copula.Parameters = corrmat;

%%
myInput = uq_createInput(InputOpts);


%% 2.1 Cost function (I moved this after the definition of the input)
% Sample the environmental variables that will be used for evaluating Pf
% within the cost function
Z = uq_getSample(myInput,1e4);
% Define the cost function
RBDOOpts.Cost.mFile = 'uq_Ex02_RubBreakwat_cost';
% Specify the parameters of the cost function, herein the sampled Z
RBDOOpts.Cost.Parameters.Z = Z ;
%%
RBDOOpts.Input.EnvVar = myInput;

%% 4 - OPTIMIZATION SETUP
%
RBDOOpts.Optim.Bounds = [3 1 10 4.5 2.5 5 7 0.52 0.32; ... 
    4 2 12 5.7 4.2 8.4 10 0.67 0.46];

%% Starting Points
%
RBDOOpts.Optim.StartingPoint = [3.4 1.3 11.2 5.1 3.35 6.7 8 0.59 0.38];

%% Target Failure Probability
% 
RBDOOpts.TargetPf = 0.001;

%% 5 - RELIABILITY-BASED DESIGN OPTIMIZATION (RBDO)
% %
RBDOOpts.Type = 'RBDO';
RBDOOpts.Method = 'two-level';

%% 5.1 Quantile Monte Carlo (QMC) with IP
%
QIPOpts = RBDOOpts;
QIP.Method = 'QMC';
QIPOpts.Optim.Method = 'IP';

%%
% Set the maximum number of iterations:
QIPOpts.Optim.MaxIter = 100;

%%
% Set the finite difference step size:
QIPOpts.Optim.IP.FDStepSize = 0.1;

%%
% Set the maximum sample size:
QIPOpts.Reliability.Simulation.MaxSampleSize = 1e5;

%%
% Run the RBDO analysis:
myRBDO_QIP = uq_createAnalysis(QIPOpts);

%%
% Print out a report of the results:
uq_print(myRBDO_QIP)

%%
% Display a graphical representation of the results:
uq_display(myRBDO_QIP)

% %% 5.1 Reliability index approach (RIA)
% %
% % Select RIA to solve the RBDO problem:
% RIAOpts = RBDOOpts;
% RIAOpts.Type = 'RBDO';
% RIAOpts.Method = 'RIA';
% 
% %%
% % Run the RBDO analysis:
% myRBDO_RIA = uq_createAnalysis(RIAOpts);
% 
% %%
% % Print out a report of the results:
% uq_print(myRBDO_RIA)
% 
% %%
% % Display a graphical representation of the results:
% uq_display(myRBDO_RIA)