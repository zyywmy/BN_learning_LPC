clear 
% Get the Trajectory of DAGs
AUC_DGEs=zeros(1,5);
AUC_UGEs=zeros(1,5);
recalls=zeros(1,5);
precisions=zeros(1,5);
accs=zeros(1,5);
fname2=sprintf('%s%d%s','H:\buf\NetRec\data\bn_data\bn_AUC.mat');

for j=1:5


fname1=sprintf('%s%d%s','H:\buf\NetRec\data\bn_data\bn_test_',j,'.mat');
load(fname1);
% Get the posterior probabilities for DGE and DGE
DAGmDGE=media(DAGs,1);
DAGmUGE=media_UGE(DAGs);
%% Load the true netowork, the network which the data was generated from

idxtm=load('true_mat_hptc.txt');
% Get the AUC values
AUC_DGEs(j)=DGEAurocValueNoDiag2(DAGmDGE,idxtm,1,1)
AUC_UGEs(j)=UGEAurocValueNoDiag2(DAGmUGE,idxtm,1,1)

% Get the ROC curves with the AUC values
DGERocCurveNoDiag2(DAGmDGE,idxtm,1,1)
UGERocCurveNoDiag2(DAGmUGE,idxtm,1,2)

cd ('H:\projects\constraint_bn');
dag=zeros(11,11);
 for ii=1:length(idxtm)
      dag(idxtm(ii,1),idxtm(ii,2))=1;
      dag(idxtm(ii,2),idxtm(ii,1))=1;
 end
 DAGmUGE(find(DAGmUGE>0.5))=1;
 DAGmUGE(find(DAGmUGE<=0.5))=0;
[recall,precision,acc]=compare_uge(DAGmUGE,dag);
recalls(j)=recall;
precisions(j)=precision;
accs(j)=acc;
cd ('H:\buf\Software_Germany\DGeUGe\');
end
save(fname2,'AUC_DGEs','AUC_UGEs','recalls','precisions','accs');