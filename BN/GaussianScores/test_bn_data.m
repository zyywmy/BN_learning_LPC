
% ----------------
% Data from Bioinformatics Vol 24(18):2071-2078
% ----------------

% Load here your data.

%load('H:\buf\NetRec\data\bn_data\data\Synthetic_Matlab\DATA.mat');
%load('H:\buf\NetRec\data\bn_data\data\Synthetic_Matlab\DATA_480_1.mat');
type={'Gaussian_Int','Gaussian_Int_Vstr','Gaussian_Obs','Gaussian_Obs_Vstr','Netbuilder_Int_Noise_001',...
    'Netbuilder_Int_Noise_01','Netbuilder_Int_Noise_001_Vstr','Netbuilder_Int_Noise_03',...
    'Netbuilder_Int_Noise_01_Vstr','Netbuilder_Int_Noise_03_Vstr','Netbuilder_Obs_Noise_001',...
    'Netbuilder_Obs_Noise_01','Netbuilder_Obs_Noise_03','Netbuilder_Obs_Noise_001_Vstr','Netbuilder_Obs_Noise_01_Vstr',...
    'Netbuilder_Obs_Noise_03_Vstr','Real_Int','Real_Obs','werhli'};
for i=19:19
    
for j=1:5

cd('../GaussianScores');
fname2=sprintf('%s%s%s%s%s%d%s','H:\buf\Software_Germany\data\',type{i},'\',type{i},'_',j,'.txt');
fname1=sprintf('%s%s%s%d','H:\buf\NetRec\data\bn\',type{i},'_',j);
%fname2=sprintf('%s%d%s','H:\buf\Software_Germany\data\Gaussian_Int\Gaussian_Int_',j,'.txt');
%fname2=sprintf('%s%d%s','H:\buf\Software_Germany\data\Netbuilder_Int_Noise_001\Netbuilder_Int_Noise_001_',j,'.txt');
%fname2=sprintf('%s%d%s','H:\buf\Software_Germany\data\Real_Int\Real_Int_',j,'.txt');
%fname2=sprintf('%s%d%s','H:\buf\Software_Germany\data\Real_Obs\Real_Obs_',j,'.txt');
%fname2=sprintf('%s%d%s','H:\buf\Software_Germany\data\Netbuilder_Int_Noise_01\Netbuilder_Int_Noise_01_',j,'.txt');
%fname2=sprintf('%s%d%s','H:\buf\NetRec\data\sim_dat\x_',j,'.txt');
%[T_0, T_m, v, alpha] = Compute_Prior_Info(DATA{j});
Data=dlmread(fname2,'\t');
Data=Data(:,1:11);
Data=Data';
[T_0, T_m, v, alpha] = Compute_Prior_Info(Data);


Nbest=176;
minDifference=1000;
flag_prior=1;
%SCORES=SBmcmc_MakeScoreStructureGaussian(x,T_0,T_m,v,alpha,'Nbest',Nbest,'minDifference',minDifference,'flag_prior',flag_prior);
%SCORES=SBmcmc_MakeScoreStructureGaussian(DATA{j},T_0,T_m,v,alpha,'flag_prior',flag_prior);
SCORES=SBmcmc_MakeScoreStructureGaussian(Data,T_0,T_m,v,alpha,'flag_prior',flag_prior);
cd('../MCMCOrder');
NroMcmcSteps=10000;
SampleInterval=10;

Results=MCMCORunSmart(SCORES,NroMcmcSteps,SampleInterval);


[DAGs,logDAGscores]=OrderMCMC_SampleDAGsGivenOrder(SCORES,Results.sampled_order,20);

%% Now you have your trajectory of DAGs you can store it if you wish.
cd('../DGeUGe');
DAGmDGE=media(DAGs,1);
DAGmUGE=media_UGE(DAGs);
save (fname1,'DAGmDGE','DAGmUGE');

end
end

