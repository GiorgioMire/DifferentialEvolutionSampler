for dim=1:d
for chain=1:N

    figure(30+dim)
    plot(XHMean{chain}(:,dim))
    hold on
end
end
drawnow
hold off