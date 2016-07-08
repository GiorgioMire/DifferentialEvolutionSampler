close all
burnin=1%20000;
for dim=1:d
figure
for chain=1:N
plot(XH{chain}(burnin:end,dim))
hold on
end
title(sprintf('Dimensione %i',dim))
end

for dim=1:d
figure
for chain=1:N
histogram(XH{chain}(burnin:end,dim),100)%'normalization','probability','FaceAlpha',0.8)
hold on
end
title(sprintf('Dimensione %i',dim))
end
clear f
clear x
for dim=1:d
figure
for chain=1:N
[f{chain,dim},x{chain,dim}]=ecdf(XH{chain}(burnin:end,dim));
plot(x{chain,dim},f{chain,dim});
hold on
end
title(sprintf('Dimensione %i',dim))

end

for dim=1:d
figure
for chain=1:N
    
        [xu,idx]=unique(x{chain,dim});
        ibad=setdiff(1:length(x{chain,dim}),idx)
        fu=f{chain,dim};
        fu(ibad)=[];
        g=interp1(xu,fu,x{1,dim});
 plot(g,f{1,dim});
hold on
end
title(sprintf('Dimensione %i',dim))
end