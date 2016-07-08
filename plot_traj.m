figure(55)
% etatilde=etatilde_4;
plot(trajectory(1,:),trajectory(2,:),'r')
t=52;
hold on
for chain=1:N
plot(etatilde(1,1:end-1,chain),etatilde(2,1:end-1,chain),'b')
end
hold off