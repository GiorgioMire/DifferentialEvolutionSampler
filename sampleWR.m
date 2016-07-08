function [sample,v]=sampleWR(v)
idx=randi(length(v));
sample=v(idx);
v(idx)=[];
end