clc;clear;

GA_best = GA();
DPSO_best = DPSO();

GA_fit = [GA_best.fitness];
DPSO_fit = [DPSO_best.fitness];

x = 1:140;
best = zeros(1,40);
best(:) = 401.1677;
figure(1);
plot(x,GA_fit(x),'-rs','LineWidth',1.2);
hold on
plot(x,DPSO_fit(x),'-bv','LineWidth',1.2);
%hold on
%plot(0:39,best,'-k*','LineWidth',1.2);
grid on
legend('遗传算法','离散粒子群算法');
xlabel('迭代次数','FontSize',13,'FontWeight','normal');
ylabel('适应度/W','FontSize',13,'FontWeight','normal');
title('10×10网络，k=8，r=6','FontSize',15,'FontWeight','bold','Color','r');