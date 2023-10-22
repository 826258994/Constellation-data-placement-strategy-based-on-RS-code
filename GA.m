function GA_best = GA()
clear;clc;close all

%% 参数设置
PopSize = 200;
MaxGen = 200;
SG = creatSG();

%% 初始化
Population = Init(PopSize,SG.S,SG.r); %初始化种群个体
Population = search_cpNode(SG,Population);%找每个个体对应的计算节点
Population = Total_eng(SG,Population); %计算初始适应度
Population = penalty(SG,Population); %计算初始罚函数
%初始化种群最优个体，初始适应度设成很大
G_best = Population(1);
G_best.fitness = 1e8;
epoch_best(1) = G_best; %每次迭代的最优解
%% 开始优化求解
for k = 1:MaxGen
    MatingPool = TournamentSelection(3,PopSize,[Population.penaty],[Population.fitness]); %挑选父代
    Offspring = Cross_variation(Population(MatingPool),SG); %进行交叉变异操作，得到交叉变异后的子代
    %从父代和交叉后子代中挑选产生新的子代，交叉子代比父代更好就更新父代，否则不更新
    Population = EnviornmentalSelection(Population,Offspring,k/MaxGen); 
    %在满足约束条件的个体里找适应度最小的
    index1 = [Population.penaty] == 0; 
    Population_suit = Population(index1);
    if ~isempty(Population_suit)
        [~,index2] = sort([Population_suit.fitness]);
        if Population_suit(index2(1)).fitness < G_best.fitness
            G_best = Population_suit(index2(1));
        end
    end
    epoch_best(k) = G_best;
    disp(['第',num2str(k),'次迭代',newline,'目前最优适应度为：',num2str(G_best.fitness),newline,...
        '对应放置策略为：',num2str(G_best.x),newline,'计算节点为：',num2str(G_best.xe)]);
end
GA_best = epoch_best;
end