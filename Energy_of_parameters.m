function [E,nutilde,etatilde,residual]=Energy_of_parameters(parameters,noiseVariance)
global trajectory
global tau
global parametri_ottimi
assert(isa(parameters, 'double'))
assert(isa(noiseVariance, 'double'))
coder.varsize('parameters',[1, 10],[0 1])
if sum(parameters<-0.01) || sum(parameters>3*parametri_ottimi+10)
    E=inf;
    nutilde=0*ones(3,30001);
     etatilde=0*ones(3,30001);
     residual=0*ones(2,30000);
else
[E,nutilde,etatilde,residual]=Energy(trajectory,tau,parameters,noiseVariance);
end
 
end