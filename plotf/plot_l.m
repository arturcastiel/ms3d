load graphs
width=550;
height=400
set(gcf,'position',[x0,y0,width,height])
%loglog(A(:,2),A(:,3))
semilogx(A(:,2),A(:,5)/60,"LineWidth",3)
yticks([0:0.25:3.6])
xlim([min(A(:,2)), max(A(:,2))])
hold on

xticks([A(:,2)'])
semilogx(A(:,2),A(:,3)/60,"LineWidth",3)
%legend('Solver', 'Preprocessing', '', '')
hold on
scatter(A(:,2),A(:,5)/60,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0.2 .8 .8],...
              'LineWidth',1.5)
scatter(A(:,2),A(:,3)/60,'MarkerEdgeColor',[1 .2 .2],...
              'MarkerFaceColor',[0.8 .15 .15],...
              'LineWidth',1.5)
legend({'Solver','Preprocessing','',''},'Location','northwest')



grid on
xtickangle(45)
