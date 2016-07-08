clear all
close all
load('Traiettoria.mat');
load('parametri_ottimi.mat')
nu=sim_vfides.getElement('nu').Values.Data.';
tau=sim_vfides.getElement('tau_tot').Values.Data.';
eta=sim_vfides.getElement('eta').Values.Data.';
trajectory=eta(1:2,1:30000);
tau=tau(:,1:30000);
parametri_ottimi=parametri_ottimi+1;
[E,n,e]=Energy_mex(trajectory,tau,parametri_ottimi);