figure(11)
etahist=etahist(:,any(etahist));
H=hist3(etahist.',[1000,1000]);
H=H/sum(sum(H));
H1 = H';
H1(size(H,1) + 1, size(H,2) + 1) = 0;
xb = linspace(min(etahist(1,:)),max(etahist(1,:)),size(H,1)+1);
yb = linspace(min(etahist(2,:)),max(etahist(2,:)),size(H,1)+1);
 surf(xb,yb,H1,'LineStyle','none');
colormap(jet)
 view(0,90)
 xlim([0 120])
 ylim([-6 6])
