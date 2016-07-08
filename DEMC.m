
answer=input('resume?')
saved='salvataggio14.mat'
if answer
   
    load(saved)
    savePeriod=2000;
else
clear all
close all
saved='salvataggio14.mat'
load('Traiettoria.mat');
load('parametri_ottimi.mat')
global trajectory
global tau
global parametri_ottimi
nu=sim_vfides.getElement('nu').Values.Data.';
tau=sim_vfides.getElement('tau_tot').Values.Data.';
eta=sim_vfides.getElement('eta').Values.Data.';

% codegen Energy_of_parameters
%  codegen UpdatePopulation
savePeriod=2000;
d=8;
N=3;
M0=2*N*d;
K=1;
gammaPeriod=5;
prior=@()2*parametri_ottimi*rand()+rand();
Epochs=inf%100000;
gamma0=2.38/sqrt(2*d);
stdE=1e-6;
T=1%(0.2/3)^2%(0.20/3)^2;
%Initialize M0 x d matrix Z sampling from prior.
noiseVariance=(0.2/3)^2;
 trajectory=eta(1:2,1:30000)+sqrt(noiseVariance)*randn(2,30000);
tau=tau(:,1:30000);
assert(M0>max(d,N));
for j=1:M0
    Z(j,:)=prior();
end
% Copy the first N rows of Z in X and set M<-M0
X=Z(1:N,:);
for chain=1:N
    Energies(1,chain)=Energy_of_parameters_mex(X(chain,:),noiseVariance);
end
M=M0;
converged=0;
epoch=0;
etahist=[];
end

while ~converged 
    tic
    epoch=epoch+1;
    if mod(epoch,100)==0
        epoch
        mean(accepted(:,1))
    end
    if epoch==Epochs
        break
    end
% K times update population
for s=1:K

    [X,Energies(epoch+1,:),accepted(epoch,:),etatilde,residual]=UpdatePopulation_mex(X,Z,epoch,gammaPeriod,gamma0,stdE,T,Energies(epoch,:));
   save([ 'res' num2str(epoch) '.mat' ],'residual');
    % for j=1:N
% etahist=[etahist,etatilde(1:2,1:end-1,j)];
% 
% end
end
% C=jet(1000);
%         figure(10)
% plot(trajectory(1,:),trajectory(2,:))
% hold on
% 
% for j=1:N
% plot(etatilde(1,1:end-1,j),etatilde(2,1:end-1,j),'Color',C(epoch,:))

% hold on
% end
% ylim([-6 6])
% xlim([-1 120])
% drawnow
% figure(11)
% H=hist3(etahist.',[100,100]);
% H1 = H';
% H1(size(H,1) + 1, size(H,2) + 1) = 0;
% xb = linspace(min(etahist(1,:)),max(etahist(1,:)),size(H,1)+1);
% yb = linspace(min(etahist(2,:)),max(etahist(2,:)),size(H,1)+1);
%  surf(xb,yb,H1,'LineStyle','none');
% colormap(jet)
%  view(0,90)
%  xlim([0 120])
%  ylim([-6 6])




% hold off

Z=[Z;X];
M=M+N;

for chain=1:N
XH{chain}(epoch,:)=X(chain,:);
XHMean{chain}(epoch,:)=mean(XH{chain},1);
end
assert(M==size(Z,1))
if(mod(epoch,savePeriod)==0)
save(saved)
end
% Check if X has converged
% Check if the total number of update is greater than G
tocs(epoch)=toc;
end
