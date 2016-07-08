function [X,Energies,accepted,etatilde,residual]=UpdatePopulation(X,Z,epoch,gammaPeriod,gamma0,stdE,T,Energies)%#codegen
   global trajectory
assert(isa(X, 'double'))
coder.varsize('X',[80, 10],[1 1])
assert(isa(Z, 'double'))
coder.varsize('Z',[1e8, 10],[1 1])
assert(isa(epoch, 'double'))
assert(isa(gammaPeriod, 'double'))
assert(isa(gamma0, 'double'))
assert(isa(stdE, 'double'))
assert(isa(T, 'double'))
assert(isa(Energies, 'double'))
coder.varsize('Energies',[1, 80],[0 1])

 
% parfor?
N=size(X,1);
M=size(Z,1);
if mod(epoch,5)==0
    gamma=1;
else
    gamma=gamma0;
end
gamma=gamma0;
zR1=zeros(size(X));
zR2=zeros(size(X));
for chain=1:N
   while 1
        R1=randi(M);
        if R1~=M-N+chain
            break
        end
    end
    
    while 1
        R2=randi(M);
        if R2~=M-N+chain  || R2~=R1
            break
        end
    end
        zR1(chain,:)=Z(R1,:);
    zR2(chain,:)=Z(R2,:);
end

 accepted=zeros(1,N);


 etatilde=zeros(3,size(trajectory,2)+1,N);
residual=zeros(2,size(trajectory,2),N);
parfor chain=1:N
 

    xi=X(chain,:);
    xp=xi+gamma*(zR1(chain,:)-zR2(chain,:))+stdE*randn(size(xi));
%     xp=round(xp./[0.5 5 0.5 5 0.5 0.5 0.5 0.005]).*[0.5 5 0.5 5 0.5 0.5 0.5 0.005];
    [proposedEnergy,nutilde,etatilde(:,:,chain),residual(:,:,chain)]=Energy_of_parameters(xp,noiseVariance);

    if T*log(rand())<-proposedEnergy+Energies(chain)
        % Move accepted
        X(chain,:)=xp;
        Energies(chain)=proposedEnergy;
        accepted(chain)=1;

    else
        accepted(chain)=0;        % Move rejected
    end
end
end