function [E,nutilde,etatilde,residual]=Energy(trajectory,tau,parameters,noiseVariance)


persistent auv
if isempty(auv)
    auv=AUV_Class();
    
end
auv.Ts=0.01;
auv.theta=parameters.';
auv.eta0=[0;0;0];
auv.nu0=[0;0;0];
auv.reset();
etatilde=zeros(3,size(trajectory,2));
nutilde=zeros(3,size(trajectory,2));
for t=1:size(trajectory,2)-1
   [nutilde(:,t),etatilde(:,t)]=auv.step(tau(:,t));
end
etatilde=[auv.eta0,etatilde];
%max(max(abs((trajectory-etatilde(1:2,:)))))
residual=trajectory-etatilde(1:2,1:end-1);
E=sum(sum((residual).^2)/2/noiseVariance);
% figure(10)
% plot(trajectory(1,:),trajectory(2,:))
% hold on
% plot(etatilde(1,1:end-1),etatilde(2,1:end-1),'r')
% drawnow
% hold off
end